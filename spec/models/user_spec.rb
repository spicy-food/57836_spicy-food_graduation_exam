require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:coffee_records).dependent(:destroy) }
    it { is_expected.to have_many(:bookmarks).dependent(:destroy) }
    it { is_expected.to have_many(:bookmarked_coffee_records).through(:bookmarks).source(:coffee_record) }
  end

  describe '#admin?' do
    let(:admin_user) { create(:user, :admin) }
    let(:regular_user) { create(:user) }

    it 'returns true for admin user' do
      expect(admin_user.admin?).to be true
    end

    it 'returns false for regular user' do
      expect(regular_user.admin?).to be false
    end
  end
end
