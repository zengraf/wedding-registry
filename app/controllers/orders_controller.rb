class OrdersController < ApplicationController
  before_action :require_login

  def index
    @orders = Order.where('date >= ?', Date.today).order(:date)
    filter
  end

  def archive
    @orders = Order.where('date < ?', Date.today).order(date: :desc)
    filter
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.added_by = current_user
    if @order.save
      redirect_to orders_path, success: "Zamówienie №#{@order.id} zostało pomyślnie złożone"
    else
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
    return does_not_exist if @order.nil?
  end

  def update
    @order = Order.find(params[:id])
    return does_not_exist if @order.nil?
    return not_admin if @order.confirmed? && !current_user.admin?
    if @order.update_attributes(order_params)
      redirect_to @order.date >= Date.today ? orders_path : archive_path, success: "Zamówienie №#{@order.id} zostało pomyślnie zmienione"
    else
      render 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    return does_not_exist if @order.nil?
    return not_admin if @order.confirmed? && !current_user.admin?
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
      params.require(:order).permit(:name, :surname, :phone_number, :date, :deposit, :hall, :confirmed)
    else
      params.require(:order).permit(:name, :surname, :phone_number, :date, :deposit, :hall)
    end
  end

  def does_not_exist
    redirect_to orders_path, alert: "Zamówienie №#{params[:id]} nie istnieje"
  end

  def not_admin
    redirect_to @order.date >= Date.today ? orders_path : archive_path, alert: "Ta operacja dostępna wyłącznie administratoru"
  end
end
