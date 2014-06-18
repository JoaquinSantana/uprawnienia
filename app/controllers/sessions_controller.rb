class SessionsController < Devise::SessionsController

	def new
		super
	end

	def create
		super
		@user = current_user
  		session[:user_id] = @user.id
	end

	def destroy
		session[:order_id] = nil
	    session[:user_id] = nil
	    current_user.orders.collect {|x| x.destroy! if x.status == 'niezatwierdzony'}
	    super
	end
end
