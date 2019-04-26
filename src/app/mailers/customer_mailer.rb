class CustomerMailer < ApplicationMailer
  def confirm_register(customer)
    @customer = customer
    mail(subject: '登録完了', to: @customer.email) do |format|
      format.text
    end
  end
end
