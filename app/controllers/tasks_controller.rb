class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: %i(edit show update destroy)
  before_action :logged_in_user
  before_action :correct_user, only: %i(new)
  before_action :admin_or_correct, only: %i(edit show)
  before_action :correct_test, only: %i(index edit show)

  def new
    @task = Task.new
  end
  
  def index
     @tasks = @user.tasks
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def show
    @user = User.find_by(params[:id])
    @task = Task.find(params[:id])
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user,@task)
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
    @task.destroy
    flash[:success] = "タスクを削除しました。" 
    redirect_to user_tasks_url
  end
  
  private
  
   def task_params
     params.require(:task).permit(:name, :detail)
   end
   
   def set_user
     @user = User.find(params[:user_id])
   end
   
   def set_task
     unless @task = @user.tasks.find_by(id: params[:id])
       flash[:danger] = "権限がありません。"
       redirect_to user_tasks_url
     end
   end
   
   def correct_test
     redirect_to user_tasks_url unless current_user?(@user)
   end
end