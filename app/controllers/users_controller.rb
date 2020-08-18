class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit]
	def show
	  @user = User.find(params[:id])
	  @posts = @user.post
	  @users = current_user
      @favorites = Favorite.where(user_id: @user.id).all
	end

	def edit
  	  @user = User.find(params[:id])
	    if current_user !=  @user
	      redirect_to user_path(current_user)
	    end
	end

    def update
      @user = User.find(params[:id])
        if @user.update(list_params)
          redirect_to user_path, notice: '変更しました'
        end
    end

    def index
	  @user = current_user
	  @favorites = Favorite.where(user_id: @user.id).all
  	end

	private
	  def list_params
	    params.require(:user).permit(:name, :introduction, :profile_image)
	  end
end
