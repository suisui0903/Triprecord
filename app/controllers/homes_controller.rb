class HomesController < ApplicationController
	def top
		@posts = Post.all
		@random = Post.order("RANDOM()").limit(5)
    end

    def about
    end

    private
	  def post_params
	    params.require(:post).permit(:title, :image, :caption, :place)
	  end
end

