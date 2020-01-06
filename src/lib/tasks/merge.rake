require('csv')

namespace :merge do
  desc 'CSVを元に、顧客をマージする'
  task :by_csv, [:csv_path] => :environment do |task, args|
    csv_full_path = Rails.root.join args[:csv_path]

    Customer.transaction do
      deleted_customers = merge_by_csv(csv_full_path)
      File.open('deleted_customers.csv', 'w') do |file|
        csv_text = CSV.generate do |csv|
          csv << Customer.column_names
          deleted_customers.each do |user|
            csv << user.attributes.values_at(*Customer.column_names)
          end
        end

        file.puts csv_text
      end
    end
  end

  def merge_by_csv(csv_file_path)
    return CSV
      .read(csv_file_path, headers: true, encoding: 'Shift_JIS:UTF-8')
      .group_by { |row| row['email'] }
      .map { |email, rows|
        merge_to_row = rows.select { |row| row['merge_to'] === 'TRUE' }
        merge_from_row = rows - merge_to_row

        merge_from_id = merge_from_row.first['id']
        merge_to_id = merge_to_row.first['id']

        Customer.merge(merge_from_id, merge_to_id)
      }
  end
end