class Micropost < ApplicationRecord
  DATA_TYPE = %i(content picture)
  belongs_to :user
  scope :order_desc, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.max_content_post}
  validate :picture_size

  private

  # Validates the size of an uploaded picture.
  def picture_size
    return unless picture.size > Settings.size_upload_picture.megabytes

    errors.add :picture1, I18n.t(".oversize_upload_picture")
  end
end
