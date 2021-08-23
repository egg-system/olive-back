class Customers::CsvController < ApplicationController
  def index
    filename = 'customers_' + Date.current.strftime("%Y%m%d")
    headers.delete("Content-Length")
    headers["Cache-Control"] = "no-cache"
    headers['Content-Type'] = 'text/csv'
    headers['X-Accel-Buffering'] = 'no'
    response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.csv"'
    self.response_body = build_csv
  end

  def build_csv
    bom = "\uFEFF"
    Enumerator.new do |csv|
      csv << bom
      csv << Customer::JP_COLUMN_NAMES.to_csv
      Customer.find_each do |customer|
        csv << customer.attributes.values.to_csv
      end
    end
  end
end


