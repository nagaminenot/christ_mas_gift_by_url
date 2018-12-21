class Gift < ApplicationRecord
  require "securerandom"
  before_save :set_slug
  after_save :update_ogp
  validates :giver_name, presence: true
  validates :taker_name, presence: true
  validates :slug, uniqueness: true

  def set_slug
    if self.slug.present?
      true
    else
      self.slug = SecureRandom.hex(32)
    end
  end

  def update_ogp
    ogp_image_generator = GiftOgpImageGenerator.new(self)
    ogp_image_generator.generate
  end
end
