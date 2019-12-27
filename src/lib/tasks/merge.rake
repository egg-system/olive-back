require('csv')

namespace :merge do
  desc 'CSVを元に、顧客をマージする'
  task :by_csv, [:csv_path] => :environment do |task, args|
    csv_full_path = Rails.root.join args[:csv_path]

    Customer.transaction do
      merge_by_csv(csv_full_path)
    end
  end

  def merge_by_csv(csv_file_path)
    CSV.read(csv_file_path, headers: true, encoding: 'Shift_JIS:UTF-8')
      .group_by { |row| row['email'] }
      .each { |email, rows|
        merge_to_row = rows.select { |row| row['merge_to'] === 'TRUE' }
        merge_from_row = rows - merge_to_row

        merge_from_id = merge_from_row.first['id']
        merge_from_customer = Customer.find(merge_from_id)

        merge_to_id = merge_to_row.first['id']
        merge_from_customer.reservations.update(customer_id: merge_to_id)

        merge_to_customer = Customer.find(merge_to_id)
        unless merge_to_customer.member?
          merge_to_customer.uid = merge_from_customer.uid
          merge_to_customer.encrypted_password = merge_from_customer.encrypted_password
          merge_to_customer.provider = 'email'
        end

        merge_from_customer.destroy
        merge_to_customer.save     
      }
  end
end