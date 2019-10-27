class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def index
    @tasks = Task.all
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "タスク新規作成しました。"
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  
  private
  
   def task_params
     params.require(:task).permit(:name, :detail)
   end

end
