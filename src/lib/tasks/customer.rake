require('csv')

namespace :customer do
  desc 'CSVを元に、顧客をマージする'
  task :merge_by_csv, [:csv_path] => :environment do |task, args|
    csv_full_path = Rails.root.join args[:csv_path]

    Customer.transaction do
      deleted_customers = merge_by_csv(csv_full_path)
      export_csv('deleted_customers.csv', deleted_customers)
    end
  end

  def merge_by_csv(csv_file_path)
    csv = CSV.table(csv_file_path, headers: :first_row, encoding: 'Shift_JIS:UTF-8')
    headers = csv.headers
    merge_to_col_index = headers.find_index(:merge_to)

    csv.flat_map { |row|
      merge_to_id = row[merge_to_col_index]
      (0...headers.length).filter { |i|
        headers[i] == :merge_from && row[i].present?
      }.map { |i|
        merge_from_id = row[i]
        Customer.merge(merge_from_id, merge_to_id)
      }
    }
  end

  desc '顧客統合CSVにエラーがないかチェックする'
  task :check_customers_in_csv, [:csv_path] => :environment do |task, args|
    csv_full_path = Rails.root.join args[:csv_path]
    check_customers_in_csv(csv_full_path)
  end

  def check_customers_in_csv(csv_file_path)
    csv = CSV.table(csv_file_path, headers: :first_row, encoding: 'Shift_JIS:UTF-8')
    headers = csv.headers

    is_error = false
    customer_ids = []
    csv.each_with_index { |row, csv_index|
      row_num = csv_index + 2
      (0...headers.length).filter { |i|
        (headers[i] == :merge_from || headers[i] == :merge_to) && row[i].present?
      }.each { |i|
        customer_id = row[i]
        if customer_ids.include?(customer_id)
          puts "ERROR IDが重複しています。ID：#{customer_id}"
          is_error = true
        end
        customer_ids.push(customer_id)
        customer_relation = Customer.where(id: customer_id)
        if !customer_relation.exists?
          puts "ERROR #{row_num}行目：対象のIDの顧客が存在しません。ID：#{customer_id}"
          is_error = true
        elsif headers[i] == :merge_to && customer_relation.where_deleted(true).exists?
          puts "ERROR #{row_num}行目：未使用の顧客が統合先に指定されています。ID：#{customer_id}"
          is_error = true
        elsif headers[i] == :merge_from && customer_relation.first.medical_record.present?
          puts "WARNING #{row_num}行目：問診票が登録済みです。問診票は自動で統合できません。ID：#{customer_id}"
        end
      }
    }
    puts 'SUCCESS CSVファイルにエラーはありませんでした。' unless is_error
  end

  desc '非会員登録した顧客を一括で会員に変更する'
  task :migrate_to_member, [:password] => :environment do |task, args|
    Customer.transaction do
      none_member_custoers = Customer.where(provider: 'none').where.not(email: nil)

      # update_allなどでは、passwordを更新できない
      none_member_custoers.each { |customer|
        customer.password = args[:password]
        customer.update!(provider: 'email')
      }

      export_csv('update_member.csv', none_member_custoers)
    end
  end

  def export_csv(csv_path, customers)
    File.open(csv_path, 'w') do |file|
      csv_text = CSV.generate do |csv|
        csv << Customer.column_names
        customers.each do |customer|
          csv << customer.attributes.values_at(*Customer.column_names)
        end
      end

      file.puts csv_text
    end
  end
end
