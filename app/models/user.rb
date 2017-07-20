# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  adress                 :string
#  avatar                 :string
#  role                   :string           default("user"), not null
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :albums, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_interrelationships, class_name:  "Interrelationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
  has_many :passive_interrelationships, class_name:  "Interrelationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :following, through: :active_interrelationships, source: :followed
  has_many :followers, through: :passive_interrelationships, source: :follower

  has_many :photos, through: :albums, source: :photos
  has_many :feed_photos, through: :following, source: :photos

  mount_uploader :avatar, AvatarUploader
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  def following?(other_user)
    following.include?(other_user)
  end

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :first_name
      indexes :last_name
    end
  end

  def display_name
    first_name + " " + last_name
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
