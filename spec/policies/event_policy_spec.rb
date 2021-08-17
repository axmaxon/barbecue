require 'spec_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :update? do
    it { is_expected.to permit(user, Event) }
    it { is_expected.not_to permit(nil, Event) }
    # it 'grant access if user is event-owner' do
    #   expect(subject).to permit(User.new())
    # end
  end

  # permissions ".scope" do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
  #
  # permissions :show? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
  #
  # permissions :create? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
  #
  # permissions :update? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
  #
  # permissions :destroy? do
  #   pending "add some examples to (or delete) #{__FILE__}"
  # end
end
