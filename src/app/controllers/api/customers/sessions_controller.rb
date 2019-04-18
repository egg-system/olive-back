class Api::Customers::SessionsController < DeviseTokenAuth::SessionsController
  include Concerns::TokenAuthenticable
  skip_before_action :authenticate_staff!
  skip_before_action :authenticate_api_customer!, only: :create

  def find_resource(field, value)
    if resource_class.try(:connection_config).try(:[], :adapter).try(:include?, 'mysql')
      @resource = resource_class
        .where("BINARY #{field} = ? AND provider= ?", value, provider)
        .where('has_membership = 1')
        .first
    else
      @resource = resource_class.dta_find_by(field => value, 'provider' => provider)
    end
  end
end
