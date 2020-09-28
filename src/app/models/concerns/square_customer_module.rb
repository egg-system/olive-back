module SquareCustomerModule
  extend ActiveSupport::Concern

  included do
    after_create :create_square_customer
  end

  def customer_api
    return square_client.customers
  end

  def has_square_customer?
    return get_square_customer.present?
  end

  def get_square_customer
    # 複数回、APIを叩かないように、インスタンス変数にキャッシュする
    unless @square_customer.nil?
      return @square_customer
    end

    result = customer_api.search_customers(
      body: {
        query: {
          filter: {
            reference_id: { exact: self.id.to_s }
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

  def is_synced_square_customer
    square_customer = get_square_customer
    square_customer_attributes.all? { |key, value|
      square_customer[key] === value
    }
  end

  def create_square_customer
    result = customer_api.create_customer(
      body: self.square_customer_attributes
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
      family_name: self.last_name,
      given_name: self.first_name,
      company_name: self.full_kana,
      email_address: self.email,
      phone_number: self.tel,
      reference_id: self.id.to_s,
    }
  end
end
