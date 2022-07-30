class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]
  before_action :set_relations, only: [:new, :show]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
    if params[:store_name].present?
      @stores = @stores.where("name like ?", "%#{params[:store_name]}%")
      @store_name = params[:store_name]
    end
  end

  def search
    return redirect_to stores_path(store_name: params[:store_name])
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id]);
    @store_menus = StoreMenu.where(store_id: params[:id]);
    @store_options = StoreOption.where(store_id: params[:id])
    @near_stores = @store.near_stores
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        @store.save_near_stores(params[:store][:near_store_ids])

        format.html { redirect_to @store, notice: I18n.t("successes.messages.create") }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        @store.save_near_stores(params[:store][:near_store_ids])

        format.html { redirect_to @store, notice: I18n.t("successes.messages.update") }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { redirect_to @store, alert: @store.errors.to_a.join('<br>') }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    begin
      @store.destroy!
      respond_to do |format|
        format.html { redirect_to stores_url, notice: I18n.t("successes.messages.destroy") }
        format.json { head :no_content }
      end
    rescue => exception
      Rails.logger.info(exception.message)
      respond_to do |format|
        format.html { redirect_to @store, alert: 'すでに利用されているため、削除できません' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_store
    @store = Store.find(params[:id])
  end

  def set_relations
    @menus = Menu.all
    @options = Option.all
    @near_store_options = Store.all
    @near_store_options = @near_store_options.where.not(id: params[:id]) if params[:id].present?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def store_params
    params.require(:store).permit(
      :store_type,
      :name,
      :short_name,
      :zip_code,
      :address,
      :tel,
      :mail,
      :url,
      :reservation_url,
      :open_at,
      :close_at,
      :break_from,
      :break_to,
      menu_ids: [],
      option_ids: []
    )
  end
end
