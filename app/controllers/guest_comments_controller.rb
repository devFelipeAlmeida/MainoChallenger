class GuestCommentsController < ApplicationController
  before_action :set_post, only: [:create]

  def create
    @guest_comment = @post.guest_comments.create(body: params[:guest_comment])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "post#{@post.id}comments",
          partial: "posts/post_comments",
          locals: { post: @post }
        )
      end
    end
  end

  def destroy
    @guest_comment = GuestComment.find(params[:id])
    @guest_comment.destroy
  
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(
          "post#{@guest_comment.post_id}ModalComment#{@guest_comment.id}"
        )
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end