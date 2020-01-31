class Guest < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :photo, presence: true
  has_one_attached :photo

  def as_json_with_photo
    as_json.merge(
      photo.attached? ? {photo_url: url_for(photo)} : {}
    )
  end
end
