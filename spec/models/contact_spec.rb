require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:message) }
  end
end
