require 'rails_helper'

RSpec.describe CoffeeRecord, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:bookmarks).dependent(:destroy) }
    it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }
  end

  describe 'constants' do
    it 'defines ROAST_LEVELS' do
      expect(CoffeeRecord::ROAST_LEVELS).to be_an(Array)
      expect(CoffeeRecord::ROAST_LEVELS).to include('ライトロースト', 'ミディアムロースト', 'フレンチロースト')
    end
  end

  describe '#can_delete?' do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, :admin) }
    let(:other_user) { create(:user) }
    let(:coffee_record) { create(:coffee_record, user: user) }

    it 'returns true for record owner' do
      expect(coffee_record.can_delete?(user)).to be true
    end

    it 'returns true for admin user' do
      expect(coffee_record.can_delete?(admin_user)).to be true
    end

    it 'returns false for other users' do
      expect(coffee_record.can_delete?(other_user)).to be false
    end
  end
end