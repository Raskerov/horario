require 'spec_helper'

describe Api::UsersController do
  let(:company) { create(:company) }
  let(:user) { create(:user, :worker, email: 'some@email.com', company: company) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    subject { get :show }

    it 'return user data' do
      expect(subject).to have_http_status(:ok)
      body = MultiJson.load(subject.body, symbolize_keys: true)
      expect(body).to match({
                              email: "some@email.com",
                              full_name: user.full_name,
                              id: user.id,
                              company: company.name,
                              role: "worker",
                              joined: true,
                            })
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: params }

    context 'valid form' do
      let(:params) { { email: 'new@email.com', full_name: 'New name' } }

      it 'returns updates user' do
        expect(subject).to have_http_status(:ok)

        body = MultiJson.load(subject.body)
        expect(body['full_name']).to eq('New name')

        expect(user.reload.email).to eq('some@email.com')
        expect(user.unconfirmed_email).to eq('new@email.com')
        expect(user.full_name).to eq('New name')
      end
    end

    context 'invalid form' do
      let(:params) { { email: 'new', full_name: '' } }

      it 'renders errors' do
        expect(subject).to have_http_status(:bad_request)
        body = MultiJson.load(response.body)

        expect(body).to eq({
                             'error' => 'RecordInvalidError',
                             'details' => 'Validation failed: Email is invalid'
                           })
      end
    end
  end
end
