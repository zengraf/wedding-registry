class TasksController < ApplicationController
  before_action :load_order

  def index
    authorize! :read, Task
    @tasks = @order.tasks.accessible_by(current_ability)
  end

  def show
    @task = Task.find(params[:id])
    authorize! :read, @task
  end

  def new
    authorize! :create, Task
    @task = Task.new
  end

  def create
    @task = @order.tasks.build(task_params)
    if @task.save
      redirect_to order_path(@order)
    else
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
    authorize! :update, @task
  end

  def update
    @task = Task.find(params[:id])
    authorize! :update, @task
    if @task.update(task_params)
      redirect_to order_path(@order)
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    authorize! :destroy, @task
    @task.destroy
    redirect_to order_path(@order)
  end

  protected

  def task_params
    params.require(:task).permit(:name, :order_id, :description, :start_time, :end_time, :actual_price, :price)
  end

  def load_order
    @order = Order.accessible_by(current_ability).find(params[:order_id])
  rescue
    flash[:danger] = I18n.t('messages.order.not_found', id: params[:order_id])
    render 'orders/index'
  end
end
