class Customers::DuplicateController < ApplicationController
  def index
    # 重複1件につき、4倍の高さのため、件数は1/4にする ※ 顧客一覧は20件ずつで表示
    ## ペジネーション周りの情報を保持するため、変数名をpageにする
    @duplicated_customer_page = Customer.group_duplicate
      .select('group_concat(id) as duplicated_ids')
      .paginate(search_params[:page], 5)

    # TODO: 本行、以下の処理は、顧客モデル内にまとめる
    duplicated_ids_groups = @duplicated_customer_page 
      .map { |duplicated_group|
        duplicated_group.duplicated_ids
      }

    # パフォーマンスの都合から、一括取得する
    duplicated_customers = Customer.where(
      id: duplicated_ids_groups.flat_map { |ids| ids.split(',') }
    ).to_a

    # 重複している顧客ごとにグルーピングする
    @duplicated_customer_groups = duplicated_ids_groups.map{ |duplicated_ids| 
      duplicated_customers.select { |customer|
        duplicated_ids.include?(customer.id.to_s)
      }
    }
  end

  private
    def search_params
      params.permit(:page)
    end
end
