class TasksController < ApplicationController
  
  before_action :logged_in_user, only: [:new, :show, :edit, :update, :index]
  before_action :admin_or_correct_user, only: :update
  
  def new
    @task = Task.new
  end
  
  def index
    @tasks = Task.all
    @user = User.find_by(params[:id])
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def show
    @user = User.find_by(params[:id])
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_tasks_url
    else
      render :edit
    end
  end
  
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      flash[:success] = "タスク新規作成しました。"
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  
  def destroy
    @task = Task.find_by(params[:id]).destroy
    @task.destroy
    flash[:success] = "タスクを削除しました。" 
    redirect_to user_tasks_url
  end
  
  private
  
   def task_params
     params.require(:task).permit(:name, :detail)
   end
   
    def logged_in_user
      unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
      end
    end
    
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
       flash[:danger] = "編集権限がありません。"
       redirect_to(root_url)
      end
    end

end
