class SessionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	#Hien thi form dang nhap
	def new 
	end

	#Dang nhap
	def create
		@user = User.find_by_email(params[:session][:email])
		if @user && @user.authenticate(params[:session][:password])
			session[:user_id] = @user.id
			flash[:notice] = "Logged in successfully!"
			redirect_to root_path, allow_other_host: true
		else 
			flash[:notice] = "Invalid credentials"
			redirect_to '/login', allow_other_host: true
		end
	end

	#Dang xuat
	def destroy
		session[:user_id] = nil
		flash[:notice] = "You have been logged out!"
		redirect_to '/login'
	end
end
