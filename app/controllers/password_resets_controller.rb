class PasswordResetsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by(email: params[:email])
    if @user&.valid_security_answer?(params[:security_answer])
      session[:password_reset_user_id] = @user.id
      redirect_to password_reset_new_password_path
    else
      flash[:alert] = "メールアドレスまたはセキュリティ回答が正しくありません"
      render :new
    end
  end
  
  def new_password
    @user = User.find(session[:password_reset_user_id])
  end
  
  def update_password
    @user = User.find(session[:password_reset_user_id])
    if @user.update(password: params[:password], password_confirmation: params[:password_confirmation])
      session.delete(:password_reset_user_id)
      redirect_to new_user_session_path, notice: "パスワードが更新されました"
    else
      render :new_password
    end
  end
end