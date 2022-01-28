require 'spec_helper'

describe Api::Auth::PasswordsController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    subject { post :create, params: { user: { email: email } } }

    context 'valid email' do
      let(:email) { user.email }

      it 'returns success' do
        expect(subject).to be_successful
        expect(subject.body).to eq('{}')
      end
    end

    context 'invalid email' do
      let(:email) { 'a@dsa.pl' }

      it 'returns success' do
        expect(subject).to be_successful
        expect(subject.body).to eq('{}')
      end
    end
  end

  describe 'PUT #update' do
    let(:user) { create(:user, reset_password_token: token, reset_password_sent_at: 1.minute.ago) }
    let(:token) { Devise.token_generator.digest(User, :reset_password_token, 'ABC') }

    subject { put :update, params: { user: params } }

    context 'invalid token' do
      let(:params) { { reset_password_token: 'XXX', current_password: user.password, password: 'Qwerty123', password_confirmation: 'Qwerty123' } }

      it 'returns error' do
        expect(subject).to have_http_status(:bad_request)
        expect(MultiJson.load(subject.body)).to eq({ "error" => "RecordInvalidError", "details" => { "reset_password_token" => ["is invalid"] } })
      end
    end

    context 'valid token' do
      context 'validation errors' do
        let(:params) { { reset_password_token: 'ABC', current_password: user.password, password: 'Qwerty123', password_confirmation: 'Qwerty' } }

        it 'returns error' do
          expect(subject).to have_http_status(:bad_request)
          expect(MultiJson.load(subject.body)).to eq({ "error" => "RecordInvalidError", "details" => { "password_confirmation" => ["doesn't match Password"] } })
        end
      end

      context 'valid params' do
        let(:params) { { reset_password_token: 'ABC', current_password: user.password, password: 'Qwerty123', password_confirmation: 'Qwerty123' } }

        it 'returns success' do
          expect(subject).to be_successful
          expect(subject.body).to eq('{}')
        end
      end
    end
  end
end
