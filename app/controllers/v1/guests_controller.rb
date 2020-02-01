class V1::GuestsController < ApplicationController
  def index
    @guests = Guest.order(created_at: :desc).all
    render json: @guests.map{|g| guest_as_json(g)}
  end

  def create
    @guest = Guest.new(guest_params)
    if @guest.save
      render json: {success: true, guest: guest_as_json(@guest)}
    else
      render json: {success: false, errors: @guest.errors}
    end
  end

  def destroy
  end

  private

  def guest_as_json(guest)
    guest.as_json.merge(
      guest.photo.attached? ? {photoUrl: url_for(guest.photo)} : {}
    )
  end

  def guest_params
    params.require(:guest).permit(:name, :email, :photo, :browser_uuid)
  end
end
