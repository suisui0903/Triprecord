class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create, :edit, :index]
  	def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to post_path(@post.id), notice: '投稿しました'
      else
        render :new
      end
    end

    def index
       @post = Post.new
       @posts = Post.all
    end

    def show
       @posts = Post.find(params[:id])
    end

    def edit
      @posts = Post.find(params[:id])
      if current_user !=  @posts.user
        redirect_to edit_post_path
      end
  	end

  	def update
  	  post = Post.find(params[:id])
  	  if post.update(post_params)
  	    redirect_to post_path, notice: '変更しました'
  	  end
	  end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      redirect_to posts_path, notice: '削除されました'
    end

    def search
  	  if params[:place].present?
  	    @posts = Post.where('place LIKE ?', "%#{params[:place]}%")
  	  else
  	    @posts = Post.none
  	  end
	  end

    private
	  def post_params
	    params.require(:post).permit(:title, :image, :caption, :place)
	  end
end