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

    return csv.flat_map do |row|
      merge_to_id = row[merge_to_col_index]
      (0...headers.length).filter do |i|
        headers[i] == :merge_from && row[i].present?
      end.map do |i|
        merge_from_id = row[i]
        Customer.merge(merge_from_id, merge_to_id)
      end
    end
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