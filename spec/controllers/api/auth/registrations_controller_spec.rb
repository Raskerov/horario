require 'spec_helper'

describe Api::Auth::RegistrationsController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  let(:email) { attributes_for(:user)[:email] }
  let(:password) { attributes_for(:user)[:password] }
  let(:full_name) { attributes_for(:user)[:full_name] }

  before { Timecop.freeze(2019, 10, 24, 15, 12, 25, 0) }

  describe 'sign up' do
    context 'valid form' do
      it 'creates a new user' do
        post :create,
             params: {
               user: {
                 full_name: full_name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 company: 'Test company',
                 confirm_success_url: 'https://google.com',
               }
             }

        expect(response).to be_successful
        expect(User.count).to eq(1)
        expect(Company.count).to eq(1)
        expect(Company.last.name).to eq('Test company')
        expect(User.last.company_id).to eq(Company.last.id)
        expect(User.last.full_name).to eq(full_name)
      end
    end

    context 'invalid form' do
      it 'returns error' do
        post :create,
             params: {
               user: {
                 full_name: full_name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 company: '',
                 confirm_success_url: 'https://google.com',
               }
             }

        expect(response).to have_http_status(:bad_request)
        body = MultiJson.load(response.body)
        expect(body['details']).to eq("Validation failed: Name can't be blank")
      end
    end
  end
end
