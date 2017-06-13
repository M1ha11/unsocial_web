class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
end
