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
    @guest = Guest.find(params[:id])
    if params[:browser_uuid] != @guest.browser_uuid
      return render json: {success: false, errors: ['authentication error']}
    end
    if @guest.destroy
      render json: { success: true }
    else
      render json: { success: false, errors: [] }
    end
  end

  private

  def guest_as_json(guest)
    guest.as_json.merge(photoUrl: guest.small_photo_url)
  end

  def guest_params
    params.require(:guest).permit(:name, :email, :photo, :browser_uuid)
  end
end
