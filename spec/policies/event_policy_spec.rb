require 'rails_helper'
require 'pundit/rspec'

RSpec.describe EventPolicy do
  let(:user) { User.new }
  let(:event) { Event.new(user: user) }

  subject { EventPolicy }

  describe 'user is not authorized' do
    permissions :new?, :create?, :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(nil, Event) }
    end
  end

  describe 'user is not event owner' do
    let(:event) { Event.new }

    permissions :new?, :create? do
      it { is_expected.to permit(user, event) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(user, event) }
    end
  end

  describe 'user is event owner' do
    permissions :new?, :create?, :edit?, :update?, :destroy? do
      it { is_expected.to permit(user, event) }
    end
  end

  describe 'event without pin' do
    let(:event_context_without_pin) { EventContext.new(event: Event.new, pincode: nil) }

    context 'when user is anonymous' do
      permissions :show? do
        it { is_expected.to permit(nil, event_context_without_pin) }
      end
    end

    context 'when user is logged in' do
      permissions :show? do
        it { is_expected.to permit(user, event_context_without_pin) }
      end
    end
  end

  describe 'event with pin' do
    let(:event_context_without_pin) { EventContext.new(event: event, pincode: nil) }
    let(:event_context_with_pin) { EventContext.new(event: event, pincode: 'cat') }
    let(:event) { Event.new(pincode: 'cat', user: user) }
    let(:another_user) { User.new }

    context 'when user is event owner' do
      permissions :show? do
        it { is_expected.to permit(user, event_context_without_pin) }
      end
    end

    context 'when user is not event owner' do
      permissions :show? do
        it { is_expected.not_to permit(another_user, event_context_without_pin) }
      end
    end

    context 'when user is anonymous' do
      permissions :show? do
        it { is_expected.not_to permit(nil, event_context_without_pin) }
      end
    end

    context 'when user enters valid pin' do
      context 'and user is not logged in' do
        permissions :show? do
          it { is_expected.to permit(another_user, event_context_with_pin) }
        end
      end

      context 'and user is logged in' do
        permissions :show? do
          it { is_expected.to permit(nil, event_context_with_pin) }
        end
      end
    end
  end
end
