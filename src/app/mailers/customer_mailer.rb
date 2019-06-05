class CustomerMailer < ApplicationMailer
  def confirm_register(customer)
    @customer = customer
    @store = customer.first_visit_store

    mail(subject: "#{@store.name} ユーザー登録完了のお知らせ", to: @customer.email) do |format|
      format.text
    end
  end
end
