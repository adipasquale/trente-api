class Guest < ApplicationRecord
  include Rails.application.routes.url_helpers

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :photo, presence: true
  validates :browser_uuid, presence: true, uniqueness: true
  has_one_attached :photo
  after_create :send_new_guest_mail
  after_destroy :send_guest_canceled_mail


  def as_json_with_photo
    as_json.merge(
      photo.attached? ? {photo_url: url_for(photo)} : {}
    )
  end

  def send_new_guest_mail
    AdminMailer.with(guest: self).new_guest.deliver_now
  end

  def send_guest_canceled_mail
    AdminMailer.with(guest: self).guest_cancelled.deliver_now
  end

  def small_photo_url
    return nil unless photo.attached?

    if Rails.env.production?
      Cloudinary::Utils.cloudinary_url(photo.key, width: 500, height: 500, crop: :fit)
    else
      url_for(photo)
    end
  end
end
