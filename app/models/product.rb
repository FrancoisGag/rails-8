class Product < ApplicationRecord
  has_one_attached :image
  after_commit -> { broadcast_refresh_later_to "products" }

  validates :title, :description, :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validate :acceptable_image

  private

  def acceptable_image
    return unless image.attached?

    unless [ "image/gif", "image/jpeg", "image/png" ].include?(image.content_type)
      errors.add(:image, "muste be a GIF, JPG, or PNJ image")
    end
  end
end
