class UsersController < ApplicationController
  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)

    if @user.save
      #session[:user_id] = @user.id
      redirect_to :products, notice: 'New user registered'
    else
      render :new
    end
  end

  def sign_in_form
  end

  def sign_in
  end

  def sign_out
  end

  def user_params
    params.require(:user).permit(
    :first_name,
    :last_name,
    :email,
    :password_digest,
    :password_digest_confirmation
    )
  end

end
