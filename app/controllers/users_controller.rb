class UsersController < ApplicationController
	before_action :require_login, except: [:new, :create]
	before_action :require_correct_user, only: [:show, :edit, :update, :destroy]


	def index
	end

	def new

	end

  	def show
    	@user = User.find(params[:id])
    	@secret = @user.secrets
  	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			redirect_to "/users/#{user.id}"
		else
			flash[:errors] = user.errors.full_messages
			redirect_to :back
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
    	user = User.find(params[:id])
	    if user.update(user_params)
	    	flash[:success] = "User successfully created"
	      	redirect_to user
	    else
	    	flash[:errors] = user.errors.full_messages
	      	redirect_to :back
	    end
 	end

 	def destroy
 		user = User.find(params[:id])
 		if user.destroy
 			flash[:success] = "User successfully deleted"
 			redirect_to '/sessions/new'
 			reset_session
 		else
 			flash[:errors] = "User was unable to be deleted"
 		end
 	end



  

  	private
    	def user_params
      		params.require(:user).permit(:name, :email, :password, :password_confirmation)
    	end

end
