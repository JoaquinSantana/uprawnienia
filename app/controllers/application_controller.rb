class ApplicationController < ActionController::Base
	include TheRole::Controller		
	  # Prevent CSRF attacks by raising an exception.
	  # For APIs, you may want to use :null_session instead.
	  protect_from_forgery with: :exception

	  def access_denied
	    flash[:error] = t('the_role.access_denied')
	    redirect_to(:back)
	 	rescue ActionController::RedirectBackError
  		redirect_to root_path
  	end

	  private 

	  def find_ord
      @order = Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
      @order = current_user.orders.create
      session[:order_id] = @order.id  
    end
end
