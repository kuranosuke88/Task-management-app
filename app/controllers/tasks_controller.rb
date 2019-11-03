class TasksController < ApplicationController
  
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
