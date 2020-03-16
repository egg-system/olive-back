class MedicalRecordsController < ApplicationController
  def index
  end

  # GET /medical_records/1
  def show
    @customer = Customer.find(params[:id])
                      # MedicalRecord.find(customer_id: @customer.id)
    @medical_record = @custmer.medical_records
  end

  def new
    @customer = Customer.find(params[:id])
                      # MedicalRecord.new(customer_id: @customer.id)
    @medical_record = @customer.medical_records.build
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
