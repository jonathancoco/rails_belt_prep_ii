class UsersController < ApplicationController
  def create
    flash[:name] = ""
    flash[:email] = ""
    flash[:password] = ""
    flash[:errors] = []

    @user  = User.new(user_params)

    if @user.save()
      session[:user_id] = @user.id
      redirect_to products_path
    else

      flash[:errors] = @user.errors.full_messages

      @user.errors.each do |attr, msg|
        if attr.to_s == "name"
          flash[:name] =  flash[:name] + " #{msg}, "
        elsif attr.to_s == "email"
          flash[:email] =  flash[:email] + " #{msg}, "
        elsif (attr.to_s == "password" || attr.to_s =="password_confirmation")
          flash[:password] =  flash[:password] + " #{msg}, "
        end

      end

      redirect_to new_user_path
    end
  end

  def new
      flash.clear()

      if (defined?(@user)).nil? == true
        @user  = User.new
      end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email)
  end

end
