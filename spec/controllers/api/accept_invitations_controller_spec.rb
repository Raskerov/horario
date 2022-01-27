require 'spec_helper'

describe Api::AcceptInvitationsController do
  let(:company) { create(:company) }
  let(:worker) { create(:user, :worker, :unconfirmed, company: company) }
  let(:confirmation_token) { worker.confirmation_token }

  describe 'GET #fetch_confirmation' do
    subject { get :fetch_confirmation, params: { token: confirmation_token } }

    context 'worker exists and not accepted invitation yet' do
      it 'returns member email' do
        expect(subject).to be_successful

        expect(MultiJson.load(subject.body)).to eq({ 'email' => worker.email, 'company' => company.name })
      end
    end

    context 'member with the token does not exist' do
      let(:confirmation_token) { 'invalid_token' }

      it 'returns NotFound json error' do
        response_body = MultiJson.load(subject.body)

        expect(response.status).to eq(404)
        expect(response_body['error']).to eq('NotFoundError')
      end
    end

    context 'worker already accepted invitation' do
      let(:worker) { create(:user, :worker) }

      it 'returns NotFound json error' do
        response_body = MultiJson.load(subject.body)

        expect(response.status).to eq(404)
        expect(response_body['error']).to eq('NotFoundError')
      end
    end
  end

  describe 'PUT #register' do
    subject { put :register, params: params }

    before { Timecop.freeze(2019, 10, 24, 15, 12, 25, 0) }

    context 'valid form' do
      let(:params) do
        {
          token: confirmation_token,
          full_name: 'Name',
          password: 'Qwerty12345',
          password_confirmation: 'Qwerty12345',
        }
      end

      it 'updates member and returns ok status' do
        expect(subject).to have_http_status(:ok)

        expect(worker.reload.confirmed_at).to_not be_nil
        expect(worker.full_name).to eq('Name')
      end
    end

    context 'form invalid' do
      let(:params) do
        {
          token: confirmation_token,
          full_name: nil,
          password: 'Qwerty12345',
          password_confirmation: 'not_the_same',
        }
      end

      it 'renders errors' do
        expect(subject).to have_http_status(:bad_request)
        body = MultiJson.load(response.body)

        expect(body).to eq({
                            'error' => 'RecordInvalidError',
                            'details' => 'Validation failed: Password confirmation doesn\'t match Password'
                           })
      end
    end

    context 'token invalid' do
      let(:params) do
        {
          token: 'invalid_token',
          full_name: 'Name',
          password: 'Qwerty12345',
          password_confirmation: 'Qwerty12345',
        }
      end

      it 'raises error' do
        response_body = MultiJson.load(subject.body)

        expect(response.status).to eq(404)
        expect(response_body['error']).to eq('NotFoundError')
      end
    end
  end
end
