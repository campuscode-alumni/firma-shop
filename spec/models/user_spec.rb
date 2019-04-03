require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#expiration_date' do
    context 'and has active' do
      let(:user) { create(:user) }

      it 'should have an expiration date' do
        user.confirm
        expect(user.expiration_date).to eq(Time.zone.today + 90.days)
      end

      it 'shold be active status' do
        user.confirm
        expect(user.active?).to be_truthy
      end
    end

    context 'and has inactive' do
    end
  end
end
