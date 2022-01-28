require 'spec_helper'

describe Api::Auth::SessionsController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  let!(:user) { create(:user) }

  describe 'POST #create' do
    context 'credentials login' do
      context 'valid credentials' do
        subject { post :create, params: { user: { email: user.email, password: user.password } } }

        it 'logins user and returns user data' do
          expect(subject).to be_successful
          expect(MultiJson.load(response.body)['email']).to eq(user.email)
          expect(session['warden.user.user.key'][0][0]).to eq(user.id)
          expect(cookies['remember_user_token']).to be_nil
        end
      end

      context 'invalid credentials' do
        subject { post :create, params: { user: { email: user.email, password: 'abc' } } }

        it 'returns error' do
          expect(subject).to have_http_status(:unauthorized)
          expect(response.body).to eq('Invalid Email or password.')
          expect(session['warden.user.user.key']).to be_nil
        end
      end
    end
  end
end
