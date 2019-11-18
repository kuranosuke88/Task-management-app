class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :admin_or_correct, only: %i(show)
  
  def show
    set_user
  end

  def new
    @user = User.new
  end
  
  def index
    @users = User.all
    @users = User.paginate(page: params[:page], per_page: 20)
  end
  
  def edit
   set_user
  end
  
  def update
    set_user
    if params[:user][:password].blank?
       params[:user].delete("password")
       flash[:success] = "ユーザー情報を更新しました。"
       redirect_to user_url
    else
      render :edit
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。" 
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def logged_in_user
      unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
      end
    end
    
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
end
