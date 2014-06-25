class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :role_required
  before_action :find_ord, only: [:index]
  before_action :set_order, only: [:show, :edit, :update, :destroy, :zatwierdz, :copy]
  before_action :owner_required, only: [:show, :edit, :update, :destroy, :copy]
  before_action :copy, only: [:update]
  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @user = current_user
    
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @prac = User.select{|x| x.branch == current_user.branch }
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.create(order_params)
     respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if @order.update_attributes(order_params)
      redirect_to @order, notice: "Pracownicy zostali dodani do wnisoku"
    else
      render :edit
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if @order.niezatwierdzony?
      @order.destroy
      respond_to do |format|
        format.html { redirect_to root_url }
        flash[:success] = "Wniosek został usunięty"
        format.json { head :no_content }
      end
    else
      redirect_to @order
      flash[:error] = "Na tym etapie nie możesz usunąć wniosku"
    end
  end

  def zatwierdz
    if @order.order_items.empty?
      redirect_to @order
      flash[:error] = "Wniosek nie posiada ról"
    elsif @order.akcept
      session[:order_id] = nil
      redirect_to @order
      flash[:success] = "Twój wniosek został przesłany do realizacji"
    else
      flash[:error] = "Wniosek jest w trakcie realizacji"
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      @owner_check_object = @order
    end


    def copy
      params[:order][:contributor_ids].each do |c|
        next if c == ''
        user = User.find(c)
        user.orders << @order
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:status, :contributor_ids => [])
    end
end
