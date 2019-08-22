class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.validates.max_length_content_micropost}
  validate  :picture_size
  scope :order_desc, ->{order created_at: :desc}
  scope :feed, ->(id){where(user_id: id)}

  private

  def picture_size
    return unless picture.size > Settings.validates.img_micropost_size.megabytes
    errors.add(:picture, I18n.t("micropost.picture_size"))
  end
end
