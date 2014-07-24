class DecisionsController < ApplicationController
  before_action :set_decision, only: [:show, :edit, :update, :destroy]

  # GET /decisions
  # GET /decisions.json
  def index
    @decisions = Decision.all
  end

  # GET /decisions/1
  # GET /decisions/1.json
  def show
  end

  # GET /decisions/new
  def new
    @decision = Decision.new
  end

  # GET /decisions/1/edit
  def edit
  end

  # POST /decisions
  # POST /decisions.json
  def create

    @order = Order.find(params[:order_id])
    if @order.decision.nil? && ( @order.potwierdzony? || @order.abipotwierdzam? )
      @decision = @order.build_decision(decision_params)
        if @decision.save
          if @decision.opinia == false
            @order.brak_zgody
            flash[:error] = "Wniosek został odrzucony"
          else @decision.opinia == true
            flash[:success] = "Wniosek został zaakceptowany"
          end 
          redirect_to @order
        else
          redirect_to @order
        end
    elsif !@order.decision.nil?
     flash[:error] = "Wniosek posiada już decyzję"
     redirect_to @order 
    else
     flash[:error] = "Wniosek jest w obiegu"
     redirect_to @order 
    end
  end

  # PATCH/PUT /decisions/1
  # PATCH/PUT /decisions/1.json
  def update
    respond_to do |format|
      if @decision.update(decision_params)
        format.html { redirect_to @decision, notice: 'Decision was successfully updated.' }
        format.json { render :show, status: :ok, location: @decision }
      else
        format.html { render :edit }
        format.json { render json: @decision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /decisions/1
  # DELETE /decisions/1.json
  def destroy
    @decision.destroy
    respond_to do |format|
      format.html { redirect_to decisions_url, notice: 'Decision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_decision
      @decision = Decision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def decision_params
      params.require(:decision).permit(:order_id, :opinia)
    end
end
