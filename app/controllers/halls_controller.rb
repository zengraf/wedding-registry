class HallsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def create
    @hall.create
  end

  def edit; end

  def update
    @hall.update(hall_params)
  end

  def destroy
    @hall.destroy
  end

  protected

  def hall_params
    params.require(:hall).permit(:name)
  end
end
