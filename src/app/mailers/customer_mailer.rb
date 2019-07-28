# frozen_string_literal: true

class CustomerMailer < ApplicationMailer
  def confirm_register(customer)
    @customer = customer

    mail(subject: "#{Settings.brand.name} ユーザー登録完了のお知らせ", to: @customer.email, &:text)
  end
end
