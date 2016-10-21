class Api::PostsController < Api::BaseController
  def index
    respond_with Post.all
  end

  def create
    respond_with :api, Post.create(post_params)
  end

  def destroy
    respond_with Post.destroy(params[:id])
  end

  def update
    post = Post.find(params["id"])
    post.update_attributes(post_params)
    respond_with post, json: item
  end

  private

  def post params
    params.require(:post).permit(:id, :title, :description)
  end
end
