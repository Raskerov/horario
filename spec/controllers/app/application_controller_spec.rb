require 'spec_helper'

RSpec.describe App::ApplicationController do
  render_views

  describe 'GET #index' do
    subject { get :index }

    context 'user logged in' do
      before { sign_in create(:user) }

      it { expect(subject).to be_successful }
    end

    context 'user not logged in' do
      it { expect(subject).to redirect_to('http://test.host/auth?redirect=app%2F') }
    end
  end

  describe 'GET #auth' do
    subject { get :auth }

    context 'user logged in' do
      before { sign_in create(:user) }

      it { expect(subject).to redirect_to('http://test.host/') }
    end

    context 'user not logged in' do
      it { expect(subject).to be_successful }
    end
  end
end
