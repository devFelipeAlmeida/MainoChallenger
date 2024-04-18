class GuestCommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    @guest_comment = @post.guest_comments.create(body: params[:guest_comment])
  end

  def destroy
    @guest_comment = @post.guest_comments.find(params[:id])
    @guest_comment.destroy
    redirect_to @post, notice: 'Guest comment was successfully deleted.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end