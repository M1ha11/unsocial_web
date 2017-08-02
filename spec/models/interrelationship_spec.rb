# == Schema Information
#
# Table name: interrelationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_interrelationships_on_followed_id                  (followed_id)
#  index_interrelationships_on_follower_id                  (follower_id)
#  index_interrelationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Interrelationship, type: :model do
  subject { build(:interrelationship) }
  let(:existing_interrelationship) { create(:interrelationship) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  include_examples "invalid without attributes", :follower, :followed

  it "is invalid when follower equal followed" do
    subject.follower = subject.followed
    expect(subject).to_not be_valid
  end

  it "is invalid if duplicates" do
    subject.follower = existing_interrelationship.follower
    subject.followed = existing_interrelationship.followed
    expect(subject).to_not be_valid
  end
end
