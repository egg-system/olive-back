class CustomerMailer < ApplicationMailer
  def confirm_register(customer)
    @customer = customer

    mail(subject: "#{Settings.brand_name} ユーザー登録完了のお知らせ", to: @customer.email) do |format|
      format.text
    end
  end
end
