class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @store = Store.find(params[:id]);
    @store_menus = StoreMenu.where({store_id: params[:id]});
    @menus = Menu.all
  end

  # GET /stores/new
  def new
    @store = Store.new
    @menus = Menu.all
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
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
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
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
        format.html { redirect_to stores_url, notice: 'Role was successfully destroyed.' }
        format.json { head :no_content }
      end
    rescue => exception
      respond_to do |format|
        format.html { redirect_to store_url(@store.id), notice: 'すでに利用されているため、削除できません' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:store_type, :name, :address, :tel, :mail, :url, :open_at, :close_at, :break_from, :break_to, {menu_ids: []})
    end
end
