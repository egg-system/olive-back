class CustomerMailer < ApplicationMailer
  def confirm_register(customer)
    @customer = customer
    @store = customer.first_visit_store
    @store = Store.find(1) if @store.blank? #仮：予約を経由せず会員登録するとstoreがとれないようなので

    mail(subject: "#{@store.name} ユーザー登録完了のお知らせ", to: @customer.email) do |format|
      format.text
    end
  end
end
