class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :role_required
  before_action :find_ord, only: [:index]
  before_action :set_order, only: [:show, :edit, :update, :destroy, :zatwierdz, :potwierdz]
  #before_action :owner_required, only: [:update, :destroy]
  # GET /orders
  # GET /orders.json
  def index
    # => Admin
    if current_user.admin?
      @ord = Order.all.paginate(:page => params[:page], :per_page => 10).uniq
    # => Koordynator
    elsif current_user.kord?
      branch = current_user.branch
      @ord = branch.orders.paginate(:page => params[:page], :per_page => 10).uniq
    # => Kierownik działu
    elsif current_user.kier? 
      branch = current_user.branch
      @ord = branch.orders.paginate(:page => params[:page], :per_page => 10).uniq
    elsif current_user.abi?
    # => ABI
      branch = current_user.branch
      @ord = branch.orders.dane_osob.paginate(:page => params[:page], :per_page => 10).uniq 
    elsif current_user.lokwl?
    # => Lokalny Właściciel Danych
      branch = current_user.branch
      #@ord = branch.orders.upr_lok.joins(:products, :users).where(users: { id: current_user.id}).uniq,
      @ord = branch.orders.upr_lok.select{ |x| x.products.select{|z| z.users.include?(current_user)}}.uniq
    elsif current_user.dyrektor?
    # => Dyrektor Oddziału
      branch = current_user.branch
      @ord = branch.orders.upr_glowne.paginate(:page => params[:page], :per_page => 10).uniq
    elsif current_user.gou?
    # => Główny Odbiorca Usług
      @ord = Order.all.upr_glowne.select{ |x| x.products.select{|z| z.assistants.include?(current_user)}}.uniq
    elsif current_user.gau?
    # => Główny Administrator Uprawnień
      @ord = Order.all
    end
    # => Wnioski uzytkownika
    @orders = current_user.orders
  end
  #Order.all.select{ |x| x.products.select{|z| z.users.include?(u)}}

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
    if @order.niezatwierdzony? && params[:order][:kordkom].nil? && @order.update_attributes(order_params)
      redirect_to @order, notice: "Pracownicy zostali dodani do wniosku"
    elsif !params[:order][:kordkom].nil?
      @order.kordpopr!
      @order.kordkom = params[:order][:kordkom]
      flash[:success] = 'Wniosek został przesłany do poprawy'
      redirect_to @order
    else
      redirect_to @order
      flash[:error] = "Na tym etapie nie możesz edytować wniosku"
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy

    if @order.niezatwierdzony? || @order.kordkom?
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
    if @order.order_items.empty? || @order.contributors.count == 0
      redirect_to @order
      flash[:error] = "Wniosek nie posiada ról lub nie zostali przypisani pracownicy"
    elsif @order.niezatwierdzony?
      @order.akcept
      session[:order_id] = nil
      redirect_to @order
      flash[:success] = "Twój wniosek został przesłany do realizacji"
    elsif @order.potwierdzony? && current_user.abi?
      @order.abi_potwierdzam
      flash[:success] = "Wniosek został potwierdzony przez ABI"
      redirect_to @order
    elsif current_user.lokwl? && ( @order.potwierdzony? || @order.abipotwierdzam? )
      @order.lok_potwierdzam
      flash[:success] = "Wniosek został potwierdzony przez Lokalnego Właściciela Danych"
      redirect_to @order
    elsif current_user.dyrektor? && ( @order.potwierdzony? || @order.abipotwierdzam? )
      @order.dyr_potwierdzam
      flash[:success] = "Wniosek został potwierdzony przez dyrektora"
      redirect_to @order
    elsif current_user.gou? && @order.dyrpotwierdzam?
      @order.gou_potwierdzam
      flash[:success] = "Wniosek został potwierdzony przez GOU"
      redirect_to @order
    else
      flash[:error] = "Wniosek jest w trakcie realizacji"
      redirect_to :back
    end
  end

  def potwierdz
     #current_user.kier? && @order.wobiegu?
    if @order.potwierdzam
      redirect_to @order
      flash[:success] = "Wniosek został potwierdzony"
    else
      redirect_to @order
      flash[:error] = "Wniosek został już potwierdzony"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      @owner_check_object = @order
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:status, :kordkom, :user_ids => [], :contributor_ids => [])
    end


end
