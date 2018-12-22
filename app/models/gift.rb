class Gift < ApplicationRecord
  require "securerandom"
  has_one :gift_ogp_image, dependent: :destroy
  before_save :set_slug
  after_save :update_ogp
  validates :giver_name, presence: true
  validates :taker_name, presence: true
  validates :gift_url, presence: true
  validates :slug, uniqueness: true
  include FriendlyId
  friendly_id :slug

  def set_slug
    if self.slug.present?
      true
    else
      self.slug = SecureRandom.hex(32)
    end
  end

  def update_ogp
    ogp_image_generator = GiftOgpImageGenerator.new(self)
    file_path = ogp_image_generator.generate

    tmp_gift_ogp_image = gift_ogp_image.present? ? gift_ogp_image : GiftOgpImage.new(gift: self)
    tmp_gift_ogp_image.image = File.open(file_path)
    saved_item = tmp_gift_ogp_image.save!
  end
end
