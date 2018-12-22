class UserOgpImage < ApplicationRecord
  belongs_to :gift

  mount_uploader :image, GiftOgpImageUploader

  validates :gift, presence: true

  def url
    image.url
  end
end