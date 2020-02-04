class Customers::DuplicateController < ApplicationController
  def index
    @search_params = search_params
    
    # 重複ユーザー
    @duplicate_customers = Customer.group_duplicate
    @duplicate_customers = @duplicate_customers.paginate(@search_params[:page], 20)
  end

  private
    def search_params
      params.permit(:page)
    end
end
