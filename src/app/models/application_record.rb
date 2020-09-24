class ApplicationRecord < ActiveRecord::Base
  require 'square'

  self.abstract_class = true

  protected

  def reserve_url
    return "https://#{Settings.domain.reserve}"
  end

  def square_client
    return Square::Client.new(
      access_token: ENV['SQUARE_API_TOKEN'],
      environment: Rails.env.production? ? 'production' : 'sandbox'
    )
  end
end
