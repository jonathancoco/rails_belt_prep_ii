class CommentsController < ApplicationController
  before_action :require_login

  def index
    @comments = Comment.all()
    @products = Product.all()
    @users = User.all()
  end

  def create
    @comment  = Comment.new(comment_params)

    if @comment.save()
      redirect_to product_path(@comment.product_id)
    end

  end

  def destroy

    comment = Comment.find(params[:id])

    product_id  = comment.product_id
    comment.destroy()

    redirect_to product_path(product_id)
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :product_id, :user_id)
  end
end
