class UsersController < ApplicationController
  def display_login

    flash.clear()

    if (defined?(@user)).nil? == true
      @user  = User.new
    end

    render "/users/login"
  end

  def display_registration

    flash.clear()

    if (defined?(@user)).nil? == true
      @user  = User.new
    end

    render "/users/registration"
  end

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

      render "/users/registration"
    end
  end

  def new
      flash.clear()

      if (defined?(@user)).nil? == true
        @user  = User.new
      end

      render "/users/registration"
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  def login
    flash[:name] = ""
    flash[:password] = ""

    begin
      @user = User.find_by!(email: params[:email])


      if @user.try(:authenticate, params[:password])
        session[:user_id] = @user.id
        redirect_to products_path
      else
        flash[:password] = "Invalid Password"
        flash[:errors] = @user.errors.full_messages

        # checking for nil and if nil we are creating a new object  and stuffing values  into object so they user doesn't have to reconstruct the
        # form. Need to be researched if this could be  handled better.
        @user  = User.new
        @user.email = params[:email]

        render "/users/login"
      end

    rescue ActiveRecord::RecordNotFound
      flash[:name] = "Invalid User Name"
      flash[:errors] = @user.errors.full_messages

      # checking for nil and if nil we are creating a new object  and stuffing values  into object so they user doesn't have to reconstruct the
      # form. Need to be researched if this could be  handled better.
      @user  = User.new
      @user.email = params[:email]

      render "/users/login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to users_login_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email)
  end

end
