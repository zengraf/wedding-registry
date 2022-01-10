class AgendaController < ApplicationController
  def index
    @date = params.fetch(:date, Date.current).to_date
    @orders = Order.accessible_by(current_ability).includes(:hall).where(date: @date)
    @tasks = Task.accessible_by(current_ability).on(@date)
  end
end
