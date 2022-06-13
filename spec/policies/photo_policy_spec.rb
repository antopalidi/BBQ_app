require 'rails_helper'
require 'pundit/rspec'

RSpec.describe PhotoPolicy do
  let(:user) { FactoryBot.create(:user) }
  let(:photo) { FactoryBot.create(:photo, event: event, user: user)  }
  let(:event) { FactoryBot.create(:event, user: user) }

  subject { PhotoPolicy }

  context 'user is not authorized' do
    permissions :create? do
      it { is_expected.not_to permit(nil, Photo) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(nil, photo) }
    end
  end

  context 'user is event owner' do
    permissions :create?, :destroy? do
      it { is_expected.to permit(user, photo) }
    end
  end

  context 'user is photo owner' do
    permissions :create? do
      it { is_expected.to permit(user, Photo) }
    end

    permissions :destroy? do
      it { is_expected.to permit(user, photo) }
    end
  end

  context 'user is not photo owner' do
    let(:another_user) { FactoryBot.create(:user) }

    permissions :create? do
      it { is_expected.to permit(another_user, Photo) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(another_user, photo) }
    end
  end
end
