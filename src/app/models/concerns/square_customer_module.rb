module SquareCustomerModule
  extend ActiveSupport::Concern

  included do
    after_save :sync_square_customer
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
          },
          sort: {
            field: 'CREATED_AT',
            order: 'ASC'
          }
        },
        # squareのreference_idが一致するデータから、一番古いものを取得する
        limit: 1
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
    return false if fetch_square_customer.nil?

    square_customer_attributes.all? do |key, value|
      square_customer[key] === value
    end
  end

  def sync_square_customer
    @square_customer = fetch_square_customer

    # rubocop:disable Layout/IndentationWidth, Layout/ElseAlignment, Layout/EndAlignment
    result = if @square_customer.nil?
      create_square_customer
    else
      update_square_customer(@square_customer[:id])
    end
    # rubocop:enable Layout/IndentationWidth, Layout/ElseAlignment, Layout/EndAlignment

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

  def create_square_customer
    return customer_api.create_customer(
      body: square_customer_attributes
    )
  end

  def update_square_customer(customer_id)
    return customer_api.update_customer(
      customer_id: customer_id,
      body: square_customer_attributes
    )
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
