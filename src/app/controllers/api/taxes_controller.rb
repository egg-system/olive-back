class Api::TaxesController < Api::ApiController
  def index
    render json: Tax.find_by(is_default: true) # .to_tax_json
  end
end
