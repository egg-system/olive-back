class TaxesController < ApplicationController
  # GET /taxes
  # GET /taxes.json
  def index
    @tax = Tax.find_by(is_default: true)
  end

  def toggle
    @tax = Tax.find_by(is_default: true)
    @tax.is_display_include = !@tax.is_display_include
    @tax.save
    redirect_to action: :index
  end
end
