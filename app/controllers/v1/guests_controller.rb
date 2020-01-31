class V1::GuestsController < ApplicationController
  def index
    @guests = Guest.order(created_at: :desc).all
    render json: @guests
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      render json: {success: true, guest: @guest}
    else
      render json: {success: false, errors: @guest.errors}
    end
  end

  def destroy
  end

  private

  def guest_params
    params.require(:guest).permit(:name, :email)
  end
end
