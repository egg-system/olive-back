class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected

  def reserve_url
    return "https://#{Settings.domain.reserve}"
  end
end
