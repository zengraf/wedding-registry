class OrdersController < ApplicationController
  before_action :order_exists_and_permitted?, only: %i[edit update destroy]

  def index
    @pagy, @orders = pagy(Order.upcoming.includes(:hall))
    filter
  end

  def archive
    @pagy, @orders = pagy(Order.archived.includes(:hall))
    filter
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params) do |order|
      order.added_by = current_user
    end

    if @order.save
      flash[:success] = "Zamówienie №#{@order.id} zostało pomyślnie złożone"
      redirect_to orders_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      flash[:success] = "Zamówienie №#{@order.id} zostało pomyślnie zmienione"
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

  def order_exists_and_permitted?
    begin
      @order = Order.find(params[:id])
      return not_admin if @order.confirmed? && !current_user.admin?
    rescue ActiveRecord::RecordNotFound => exception
      return does_not_exist
    end
  end

  def does_not_exist
    flash[:warning] = "Zamówienie №#{params[:id]} nie istnieje"
    redirect_to orders_path
    return false
  end

  def not_admin
    flash[:warning] = "Ta operacja jest dostępna wyłącznie administratoru"
    redirect_to @order.date >= Date.today ? orders_path : archive_path
    return false
  end
end
