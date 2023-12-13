class UsersController < ApplicationController
	skip_before_action :verify_authenticity_token 
	#Normally a Ruby on Rails app has Cross-Site Request Forgery (CSRF) protection. 
	#It should usually stay enabled, but for this practice project we need 
	#to disable it to ensure we can interact with the web app from the workspace browser correctly.

	# Hien thi form dang ky
	def new
		@user = User.new
	end

	# Luu thong tin dang ky vao db va dieu huong sang trang dang nhap
	def create
		@user = User.new(user_params)
  		@user2 = User.find_by(email: @user.email)

	  	if @user2
	    	flash[:notice] = 'This email is taken by another user'
	    	redirect_to '/signup'
	  	elsif @user.save
	    	flash[:success] = 'Registration successful. Please log in.'
	    	redirect_to '/login'
	    	puts 'success'
	  	else
	    	flash[:error] = 'Error creating user'
	    	redirect_to '/signup'
	    	puts 'error'
	  	end
	end

	private 
		def user_params
			params.require(:user).permit(:username, :email, :password)
		end
end
