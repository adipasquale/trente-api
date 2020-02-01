class Guest < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :photo, presence: true
  validates :browser_uuid, presence: true, uniqueness: true
  has_one_attached :photo

  def as_json_with_photo
    as_json.merge(
      photo.attached? ? {photo_url: url_for(photo)} : {}
    )
  end
end
