# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  images     :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  mount_uploaders :images, PostImageUploader
  serialize :images, JSON

  validates :body, presence: true, length: { maximum: 1000 }
  validates :images, presence: true

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # 投稿にいいねしたユーザーをlikesテーブルを通して取得できるようにする。
  has_many :like_users, through: :likes, source: :user
end
