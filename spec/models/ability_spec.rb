require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do

  describe 'abilities' do

    subject(:ability) { described_class.new(user) }

    shared_context 'all users' do
      let(:other_user)                      { create(:user) }
      let(:other_album)                     { create(:album, user: other_user) }
      let(:other_photo)                     { create(:photo, album: other_album) }
      let(:other_user_other_photo_comment)  { create(:comment, photo: other_photo) }
      let(:follow_other_user)               { create(:interrelationship, followed: other_user) }
    end

    shared_context 'signed in users' do
      let(:album)                           { create(:album, user: user) }
      let(:photo)                           { create(:photo, album: album) }

      let(:user_this_photo_comment)         { create(:comment, photo: photo) }
      let(:user_other_photo_comment)        { create(:comment, photo: other_photo, user: user) }
      let(:other_user_this_photo_comment)   { create(:comment, photo: photo, user: other_user) }

      let(:active_relationship)             { create(:interrelationship, follower: user, followed: other_user) }
      let(:passive_relationship)            { create(:interrelationship, followed: user, follower: other_user) }
    end

    describe "not signed in user" do
      let(:user)                    { nil }

      include_context "all users"
      it { is_expected.to not_have_abilities([:create, :destroy, :read, :update], other_user) }
      it { is_expected.to not_have_abilities([:create, :destroy, :read, :update], other_album) }
      it { is_expected.to not_have_abilities([:create, :destroy, :read, :update], other_photo) }
      it { is_expected.to not_have_abilities([:create, :destroy, :read, :update], other_user_other_photo_comment) }
      it { is_expected.to not_have_abilities([:create, :destroy, :read, :update], follow_other_user) }
    end


    context "signed in user" do
      let(:user)                            { create(:user) }

      include_context "signed in users"
      include_context "all users"

      it { is_expected.to have_abilities([:create, :destroy, :read, :update], user) }
      it { is_expected.to have_abilities(:read, other_user) }
      it { is_expected.to not_have_abilities([:create, :destroy, :update], other_user) }

      it { is_expected.to have_abilities([:create, :destroy, :read, :update], album) }
      it { is_expected.to have_abilities(:read, other_album) }
      it { is_expected.to not_have_abilities([:create, :destroy, :update], other_album) }

      it { is_expected.to have_abilities([:create, :destroy, :read, :update], photo) }
      it { is_expected.to have_abilities(:read, other_photo) }
      it { is_expected.to not_have_abilities([:create, :destroy, :update], other_photo) }

      it { is_expected.to have_abilities([:create, :destroy, :read], user_this_photo_comment) }
      it { is_expected.to have_abilities([:create, :destroy, :read], user_other_photo_comment) }
      it { is_expected.to have_abilities([:create, :destroy, :read], other_user_this_photo_comment) }
      it { is_expected.to have_abilities(:read, other_user_other_photo_comment) }
      it { is_expected.to not_have_abilities([:create, :destroy], other_user_other_photo_comment) }

      it { is_expected.to have_abilities([:create, :destroy], active_relationship) }
      it { is_expected.to not_have_abilities([:create, :destroy], passive_relationship) }
      it { is_expected.to not_have_abilities(:create, Interrelationship.new(follower: user, followed: user)) }
    end

    context "signed in admin" do
      let(:user)                            { create(:user, :admin) }

      include_context "signed in users"
      include_context "all users"

      it { is_expected.to have_abilities([:create, :destroy, :read, :update], user) }
      it { is_expected.to have_abilities([:create, :destroy, :read, :update], other_user) }

      it { is_expected.to have_abilities([:create, :destroy, :read, :update], album) }
      it { is_expected.to have_abilities([:create, :destroy, :read, :update], other_album) }

      it { is_expected.to have_abilities([:create, :destroy, :read, :update], photo) }
      it { is_expected.to have_abilities([:create, :destroy, :read, :update], other_photo) }

      it { is_expected.to have_abilities([:create, :destroy, :read], user_this_photo_comment) }
      it { is_expected.to have_abilities([:create, :destroy, :read], user_other_photo_comment) }
      it { is_expected.to have_abilities([:create, :destroy, :read], other_user_this_photo_comment) }
      it { is_expected.to have_abilities([:create, :destroy, :read], other_user_other_photo_comment) }

      it { is_expected.to have_abilities([:create, :destroy], active_relationship) }
      it { is_expected.to have_abilities([:create, :destroy], passive_relationship) }
      it { is_expected.to not_have_abilities(:create, Interrelationship.new(follower: user, followed: user)) }
    end
  end
end
