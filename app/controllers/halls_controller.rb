class HallsController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def new; end

  def create
    if @hall.save
      redirect_to halls_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @hall.update(hall_params)
      redirect_to halls_path
    else
      render 'edit'
    end
  end

  def destroy
    @hall.destroy
    redirect_to halls_path
  end

  protected

  def hall_params
    params.require(:hall).permit(:name)
  end
end
