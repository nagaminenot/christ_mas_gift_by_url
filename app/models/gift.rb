class Gift < ApplicationRecord
  require "securerandom"
  before_save :prepare_save
  validates :giver_name, presence: true
  validates :taker_name, presence: true
  validates :slug, uniqueness: true

  def prepare_save
    if self.slug.present?
      true
    else
      self.slug = SecureRandom.hex(32)
    end
  end
end
