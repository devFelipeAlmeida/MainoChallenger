class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.page(params[:page]).per(3)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.includes(:tags).find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    if params[:post][:tag_name].present?
      tag_list = params[:post][:tag_name].split(',')
      .map(&:strip)
      .select { |tag| tag.start_with?('#') }

      if tag_list.empty? || tag_list.size < params[:post][:tag_name].split(',').size
      @post.errors.add(:tag_name, "Deve começar com '#' e separada por vírgulas")
      render :new
     return 
    end

# Adiciona as tags ao post
tag_list.each do |tag_name|
tag = Tag.find_or_create_by(name: tag_name)
@post.tags << tag unless @post.tags.include?(tag)
end
end

if @post.save
redirect_to root_path, notice: 'Post criado com sucesso!'
else
render :new
end
end

  def search_tags
    @posts = Tag.find_by("name LIKE ?", "%#{params[:search_query]}%")&.posts

    if @posts.nil?
      flash[:notice] = "Nenhum post encontrado."
      redirect_to root_path
    else
      render :index
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :user_id, :allow_comments, :show_likes_count, :description, :tags, images: [])
    end
end