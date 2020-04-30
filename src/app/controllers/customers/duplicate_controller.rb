class Customers::DuplicateController < ApplicationController
  MAX_DISPLAYED_CUSTOMERS_COUNT = 20

  def index
    return if search_params[:columns].nil?

    # 重複1件につき、4倍の高さのため、件数は1/4にする ※ 顧客一覧は20件ずつで表示
    ## ペジネーション周りの情報を保持するため、変数名をpageにする
    @duplicated_customer_page = Customer
      .group_duplicated(search_params[:columns])
      .select('group_concat(id) as duplicated_ids, count(id) as duplicated_count')
      .paginate(search_params[:page], 5)

    # TODO: 本行、以下の処理は、顧客モデル内にまとめる
    duplicated_ids_groups = @duplicated_customer_page
      .map do |duplicated_group|
        duplicated_group.duplicated_ids
      end

    # パフォーマンスの都合から、一括取得する
    duplicated_customers = Customer.where(
      id: duplicated_ids_groups.flat_map { |ids| ids.split(',').first(MAX_DISPLAYED_CUSTOMERS_COUNT) }
    ).to_a

    # 重複している顧客ごとにグルーピングする
    @duplicated_customer_groups = duplicated_ids_groups.map do |duplicated_ids|
      duplicated_customers.select do |customer|
        duplicated_ids.split(',').include?(customer.id.to_s)
      end
    end

    @search_param_columns = search_params[:columns]
  end

  private

  def search_params
    params.permit(:page, columns: [])
  end
end
