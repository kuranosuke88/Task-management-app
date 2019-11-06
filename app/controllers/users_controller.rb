class UsersController < ApplicationController
  
  def show
    set_user
  end

  def new
    @user = User.new
  end
  
  def index
    @users = User.all
    @users = User.paginate(page: params[:page], per_page: 10)
  end
  
  def edit
   set_user
  end
  
  def update
    set_user
    if @user.update_attributes(user_params)
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
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
end
