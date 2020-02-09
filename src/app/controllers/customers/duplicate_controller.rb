class Customers::DuplicateController < ApplicationController
  def index
    @search_params = search_params
    
    # 重複ユーザー
    duplicate_customers_info = Customer.group_duplicate
    @duplicate_customers = []
    if duplicate_customers_info.present?
      @duplicate_customers = duplicate_customers_info.map do |first_kana, last_kana, tel|
        Customer.where_duplicate(first_kana, last_kana, tel)
      end.reduce(&:or).join_tables
      @duplicate_customers = @duplicate_customers.paginate(@search_params[:page], 20)
      # 重複するkeyのindexの配列
      @duplicate_index_list = duplicate_customers_info.map do |first_kana, last_kana, tel|
        @duplicate_customers.index { |item| item.first_kana === first_kana && item.last_kana === last_kana && item.tel === tel }
      end.compact
      @duplicate_index_list.push(@duplicate_customers.size)
    end
  end

  private
    def search_params
      params.permit(:page)
    end
end
