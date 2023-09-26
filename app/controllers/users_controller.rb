class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token 
	#Normally a Ruby on Rails app has Cross-Site Request Forgery (CSRF) protection. 
	#It should usually stay enabled, but for this practice project we need 
	#to disable it to ensure we can interact with the web app from the workspace browser correctly.
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to '/login'
			puts 'success'
		else
			redirect_to '/signup'
			puts 'error'
		end
	end

	private 
		def user_params
			params.require(:user).permit(:username, :email, :password)
		end
end
