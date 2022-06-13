require 'rails_helper'
require 'pundit/rspec'

RSpec.describe CommentPolicy do
  let(:user) { FactoryBot.create(:user) }
  let(:comment) { FactoryBot.create(:comment, event: event, user: user)  }
  let(:event) { FactoryBot.create(:event, user: user) }

  subject { CommentPolicy }

  context 'user is not authorized' do
    permissions :create? do
      it { is_expected.to permit(nil, Comment) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(nil, comment) }
    end
  end

  context 'user is comment owner' do
    permissions :create? do
      it { is_expected.to permit(user, Comment) }
    end

    permissions :destroy? do
      it { is_expected.to permit(user, comment) }
    end
  end

  context 'user is event owner' do
    permissions :create?, :destroy? do
      it { is_expected.to permit(user, comment) }
    end
  end

  context 'user is not a comment owner' do
    let(:another_user) { FactoryBot.create(:user) }

    permissions :create? do
      it { is_expected.to permit(another_user, Comment) }
    end

    permissions :destroy? do
      it { is_expected.not_to permit(another_user, comment) }
    end
  end
end
