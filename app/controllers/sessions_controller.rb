class SessionsController < ApplicationController
  def new
    flash.clear()

    if (defined?(@user)).nil? == true
      @user  = User.new
    end

  end

  def create
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

        redirect_to new_session_path
      end

    rescue ActiveRecord::RecordNotFound
      flash[:name] = "Invalid User Name"
      flash[:errors] = @user.errors.full_messrages

      # checking for nil and if nil we are creating a new object  and stuffing values  into object so they user doesn't have to reconstruct the
      # form. Need to be researched if this could be  handled better.
      @user  = User.new
      @user.email = params[:email]

      redirect_to new_session_path
    end
  end

  def destroy

    session[params[:id]] = nil

    redirect_to new_session_path
  end
end
