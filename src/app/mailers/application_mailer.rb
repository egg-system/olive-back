# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Settings.brand.system_email
  layout 'mailer'
end
