require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  let(:cookies) { { "events_#{private_event.id}_pincode" => '2222' } }

  let(:user_is_not_authorized) { PunditUser.new(user1, {}) }
  let(:user_is_authorized) { PunditUser.new(user2, cookies) }
  let(:user_is_not_authenticated) { PunditUser.new(nil, cookies) }

  let(:public_event) { create(:event, user: user1) }
  let(:another_public_event) { create(:event, user: user2) }

  let(:private_event) { create(:event, user: user1, pincode: '2222') }
  let(:another_private_event) { create(:event, user: user2, pincode: '3333') }

  subject { described_class }

  context 'when event is public' do
    permissions :update?, :edit?, :destroy? do
      context 'and user is the owner of event' do
        it { is_expected.to permit(user_is_not_authorized, public_event) }
      end

      context 'and user is not the owner of event' do
        it { is_expected.not_to permit(user_is_not_authorized, another_public_event) }
      end
    end

    permissions :show? do
      context 'and user is not owner and is not authorized for current event' do
        it { is_expected.to permit(user_is_not_authorized, public_event) }
      end
    end
  end

  context 'when event is private' do
    permissions :show? do
      context 'and user is owner of event but he is not authorized for current event' do
        it { is_expected.to permit(user_is_not_authorized, private_event) }
      end

      context 'and user is not owner but he is authorized for current event' do
        it { is_expected.to permit(user_is_authorized, private_event) }

      end

      context 'and user is not the owner and he is not authorized for current event' do
        it { is_expected.not_to permit(user_is_not_authorized, another_private_event) }
      end

      context 'and user is not authenticated, but he is authorized for current event' do
        it { is_expected.to permit(user_is_not_authenticated, private_event) }
      end
    end
  end
end
