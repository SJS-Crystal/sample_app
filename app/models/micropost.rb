class Micropost < ApplicationRecord
  DATA_TYPE = %i(content picture).freeze
  belongs_to :user
  delegate :name, to: :user, prefix: true
  scope :order_desc, ->{order created_at: :desc}
  has_one_attached :picture
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.max_content_post}
  validate :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return unless picture.attached?

    return if picture.blob.byte_size <= Settings.size_upload_picture.megabytes

    picture.purge
    errors[:picture] = I18n.t(".oversize_upload_picture")
  end
end
