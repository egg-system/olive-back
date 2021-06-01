class Customers::CsvController < ApplicationController

  def index
    filename = 'customers_' + Date.current.strftime("%Y%m%d")

    @stores = Store.all
    @visit_reasons = VisitReason.all
    @nearest_stations = NearestStation.all
    @baby_ages = BabyAge.all
    @occupations = Occupation.all
    @zoomancies = Zoomancy.all
    @sizes = Size.all

    respond_to do |format|
      format.csv do
        response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.csv"'
        render "customers/csv/index.csv.erb"
      end
    end
  end
end
