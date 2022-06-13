require 'rails_helper'
require 'pundit/rspec'

RSpec.describe SubscriptionPolicy do
  let(:user) { FactoryBot.create(:user) }
  let(:subscription) { FactoryBot.create(:subscription, event: event) }
  let(:event) { FactoryBot.create(:event, user: user) }
  let(:another_user) { FactoryBot.create(:user) }

  subject { SubscriptionPolicy }

  context 'user in not authorized' do
    permissions :create? do
      it { is_expected.to permit(nil, Subscription) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(nil, subscription) }
    end
  end

  context 'user is subscription owner' do
    let(:event) { Event.new(user: another_user) }
    let(:subscription) { FactoryBot.create(:subscription, event: event, user: user) }

    permissions :create?, :destroy? do
      it { is_expected.to permit(user, subscription) }
    end
  end

  context 'user is event owner' do
    permissions :create? do
      it { is_expected.to permit(another_user, Subscription) }
    end

    permissions :destroy? do
      it { is_expected.to permit(user, subscription) }
    end
  end

  context 'user is not a subscription owner' do
    permissions :create? do
      it { is_expected.to permit(another_user, Subscription) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(another_user, subscription) }
    end
  end
end
