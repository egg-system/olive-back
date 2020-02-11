class Customers::DuplicateController < ApplicationController
  def index
    # 重複条件を抽出（表示用にも成形）
    columns_info = create_columns_info(search_params)
    @view_info = columns_info[:view_info]

    # 重複1件につき、4倍の高さのため、件数は1/4にする ※ 顧客一覧は20件ずつで表示
    ## ペジネーション周りの情報を保持するため、変数名をpageにする
    @duplicated_customer_page = Customer.group_duplicated(columns_info[:columns])
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
        duplicated_ids.split(',').include?(customer.id.to_s)
      }
    }
  end

  private
    def search_params
      params.permit(:page, :columns)
    end

    def create_columns_info(search_params)
      columns_arr = search_params[:columns].present? ? search_params[:columns].split(',') : ['kana', 'tel']
      result = { columns: [], view_info: [] }
      if columns_arr.include?('kana')
        result[:columns] = result[:columns].concat([:first_kana, :last_kana])
        result[:view_info].push({ name: 'カナ', key: :full_kana })
      end
      if columns_arr.include?('tel')
        result[:columns].push(:tel)
        result[:view_info].push({ name: '電話番号', key: :tel })
      end
      result
    end
end
