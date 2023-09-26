class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def new 
	end

	def create
		@user = User.find_by_email(params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			session[:user_id] = @user.id
			redirect_to root_path, allow_other_host: true
		else 
			redirect_to '/login', allow_other_host: true
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to '/login'
	end
end
