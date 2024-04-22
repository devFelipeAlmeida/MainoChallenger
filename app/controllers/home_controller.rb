class HomeController < ApplicationController
    def index
        @posts = Post.page(params[:page]).per(3)
    end
end