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

require 'rails_helper'

RSpec.describe User, type: :model do

  subject { build(:user) }
  let(:existing_user) { create(:user) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  include_examples "invalid without attributes", :email, :password, :first_name, :last_name, :role

  include_examples "invalid attributes length", { param: :first_name, length: 30 },
                                                { param: :last_name, length: 30 },
                                                { param: :adress, length: 100 }

  include_examples "valid without attributes", :adress, :avatar

  it "invalid with duplicates emails" do
    subject.email = existing_user.email
    expect(subject).to_not be_valid
  end

  describe '#display_name' do
    it "returns a user's full name as a string" do
      expect(subject.display_name).to eql("#{subject.first_name} #{subject.last_name}")
    end
  end

  describe '#following?' do
    let(:first_user)   { create(:user) }
    let(:second_user)  { create(:user) }
    let!(:followership) { create(:interrelationship, followed: existing_user, follower: first_user) }
    let!(:invalid_followership) { create(:interrelationship, followed: existing_user, follower: second_user) }
    it "returns true if subject following other user" do
      expect(first_user.following?(existing_user)).to eql(true)
      expect(first_user.following?(second_user)).to eql(false)
    end
  end

  context 'elasticsearch index' do
    before(:each) { create(:user, first_name: 'appledoc') }
    it 'be indexed' do
      described_class.__elasticsearch__.refresh_index!
      expect(described_class.__elasticsearch__.search('appledoc').records.length).to eq(1)
    end
  end
end
