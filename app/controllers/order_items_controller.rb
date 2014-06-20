class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_item, only: [:edit, :update, :destroy]
  before_action :role_required
  before_action :find_ord, only: [:create, :destroy]
  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @order_item = @order.order_items.create(product_id: params[:product_id] )

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to root_url }
        flash[:success] = "Rola została dodana do wniosku"
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { redirect_to root_url }
        flash[:error] = "Wnioskujesz już o tą rolę"
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to @order_item, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_item }
      else
        format.html { render :edit }
        format.json { render json: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to @order }
      flash[:success] = "Rola została usunięta z wniosku"
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
      @owner_check_object = @order_item
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id)
    end


end
