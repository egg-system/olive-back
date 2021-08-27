class Customers::CsvController < ApplicationController
  require 'csv'
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
    CSV.generate(bom) do |csv|
      csv << Customer::JP_COLUMN_NAMES
      Customer.find_each do |customer|
        csv << customer.attributes.values
      end
    end
  end
end


