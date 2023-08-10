require 'rails_helper'

RSpec.describe UserBooking, type: :model do
  let!(:user_booking) { create(:user_booking) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:book_id) }
    it { should validate_uniqueness_of(:book_id).scoped_to(:user_id) }
  end
end
