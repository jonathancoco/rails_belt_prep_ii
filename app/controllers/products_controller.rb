class ProductsController < ApplicationController
  before_action :require_login

  def index
    @products  = Product.all()
  end

  def new
    @product = Product.new()
    @categories = Category.all()
  end

  def create

    @product = Product.new(product_params)

    if @product.save()
      #redirect_to '/products/index'
      redirect_to products_path
    else
      @product.errors.each do |attr, msg|

        if attr.to_s == "name"
          flash[:name] =  flash[:name] + " #{msg}, "
        elsif attr.to_s == "description"
          flash[:description] =  flash[:description] + " #{msg}, "
        elsif attr.to_s == "pricing"
          flash[:pricing] =  flash[:pricing] + " #{msg}, "
        end

      end
      #redirect_to "/products/new"
      redirect_to new_user_path
    end

  end

  def destroy
    product = Product.find(params[:id])

    product.destroy()

    redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
    @categories = Category.all()

  end

  def update
    flash[:name] = ""
    flash[:description] = ""
    flash[:pricing] = ""

    @product = Product.find(params[:id])

    if (@product.update(product_params))
      redirect_to '/products'
    else

      @product.errors.each do |attr, msg|

        if attr.to_s == "name"
          flash[:name] =  flash[:name] + " #{msg}, "
        elsif attr.to_s == "description"
          flash[:description] =  flash[:description] + " #{msg}, "
        elsif attr.to_s == "pricing"
          flash[:pricing] =  flash[:pricing] + " #{msg}, "
        end

      end

      redirect_to edit_product_path(@product)
    end
  end

  def show
      @product = Product.find(params[:id])
      @like = @product.likes.find_by(likeable:Product.find(@product), user_id:current_user)
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :pricing, :category_id)
  end

end
