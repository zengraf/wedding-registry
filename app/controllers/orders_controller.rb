class OrdersController < ApplicationController
  load_and_authorize_resource except: %i[index archive]

  def index
    @pagy, @orders = pagy(Order.upcoming.accessible_by(current_ability).includes(:hall))
    filter
  end

  def archive
    @pagy, @orders = pagy(Order.archived.accessible_by(current_ability).includes(:hall))
    filter
  end

  def show; end

  def new; end

  def create
    @order.added_by = current_user
    if @order.save
      redirect_to orders_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @order.update(order_params)
      redirect_to @order.date.past? ? archive_path : orders_path
    else
      render 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_url
  end

  private

  def filter
    return false unless params[:filter]

    @from = params[:filter][:from]
    @to = params[:filter][:to]
    @status = params[:filter][:status].to_i
    @orders = @orders.select { |order| order.date >= Date.parse(@from) } unless @from.empty?
    @orders = @orders.select { |order| order.date <= Date.parse(@to) } unless @to.empty?
    @orders = @orders.select { |order| order.confirmed == (@status == 1) } unless @status.zero?
  end

  def order_params
    if current_user.admin?
      params.require(:order).permit(:name, :surname, :phone_number, :date, :deposit, :hall_id, :confirmed)
    else
      params.require(:order).permit(:name, :surname, :phone_number, :date, :deposit, :hall_id)
    end
  end
end
