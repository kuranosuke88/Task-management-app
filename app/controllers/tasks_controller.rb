class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def index
    @tasks = Task.all
    @user = User.find_by(params[:id])
  end
  
  def edit
  end
  
  def show
    @user = User.find_by(params[:id])
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
    @task = Task.find_by(params[:id])
    @task.destroy
    flash[:success] = "タスクを削除しました。" 
    redirect_to user_tasks_url
  end
  
  private
  
   def task_params
     params.require(:task).permit(:name, :detail)
   end

end
