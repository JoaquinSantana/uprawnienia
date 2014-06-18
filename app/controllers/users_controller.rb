class UsersController < Devise::ApplicationController
	before_action :authenticate_user!

	def wnioski
		
	end
end
