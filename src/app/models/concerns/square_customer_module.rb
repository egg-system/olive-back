module SquareCustomerModule
  extend ActiveSupport::Concern

  included do
    after_create :create_square_customer
  end

  def customer_api
    return square_client.customers
  end

  def square_customer_exists?
    return fetch_square_customer.present?
  end

  def fetch_square_customer
    # 複数回、APIを叩かないように、インスタンス変数にキャッシュする
    return @square_customer unless @square_customer.nil?

    result = customer_api.search_customers(
      body: {
        query: {
          filter: {
            reference_id: { exact: id.to_s }
          }
        },

        # squareのreference_idが一致するデータから、一番古いものを取得する
        limit: 1,
        sort: {
          field: 'CREATED_AT',
          order: 'ASC'
        }
      }
    )

    # 成功した場合のみ、結果をキャッシュする
    if result.data.present?
      @square_customer = result.data.customers.first
      return @square_customer
    end

    return nil
  end

  def synced_square_customer?
    square_customer = fetch_square_customer
    square_customer_attributes.all? do |key, value|
      square_customer[key] === value
    end
  end

  def create_square_customer
    result = customer_api.create_customer(
      body: square_customer_attributes
    )

    if result.error?
      ExceptionNotifier.notify_exception(
        ActionController::BadRequest.new('square連携でエラーが発生ました。'),
        data: result.errors
      )
    end

    # 登録か、更新が成功した場合、キャッシュを更新する
    @square_customer = result.data.customer if result.success?

    return true
  end

  protected

  def square_customer_attributes
    return {
      family_name: last_name,
      given_name: first_name,
      company_name: full_kana,
      email_address: email,
      phone_number: tel,
      reference_id: id.to_s
    }
  end
end
