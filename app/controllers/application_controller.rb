class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :configure_permitted_edit_parameters, if: :devise_controller?
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

	protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :branch_id, :imie, :nazwisko, :branch_id, :password, :password_confirmation) }
	  end

	  def configure_permitted_edit_parameters
	    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :imie, :nazwisko, :branch_id, :password, :password_confirmation, :current_password) }
	  end

	  private 

	  def find_ord
    	@order = Order.find(session[:order_id])
    rescue ActiveRecord::RecordNotFound
    	@order = current_user.orders.create
    	@order.wnioskujacy = current_user.nazwa
    	@order.save
    	session[:order_id] = @order.id  
    end
end
