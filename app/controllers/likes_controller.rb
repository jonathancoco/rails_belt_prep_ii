class LikesController < ApplicationController
  def create
    #adding a  new comment
    if params[:like_type] == "product" ||  params[:like_type] == "product_listing"
      like = Like.create(user:current_user)
      like.update_attribute(:likeable, Product.find(params[:product_id]))
      like.save()

      if params[:like_type] == "product"
        redirect_to product_path(params[:product_id])
      else
        redirect_to products_path
      end
    else

    end

  end

  def new
  end

  def destroy
    if params[:like_type] == "product" ||  params[:like_type] == "product_listing"
      like = Like.find(params[:id])
      like.destroy()

      if params[:like_type] == "product"
        redirect_to product_path(params[:product_id])
      else
        redirect_to products_path
      end
    else

    end
  end
end
