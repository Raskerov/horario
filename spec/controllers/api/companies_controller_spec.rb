require 'spec_helper'

describe Api::CompaniesController do
  let(:company) { create(:company) }
  let(:user) { create(:user, :worker, email: 'some@email.com', company: company) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    subject { get :show }

    it 'return company data' do
      expect(subject).to have_http_status(:ok)
      body = MultiJson.load(subject.body, symbolize_keys: true)
      expect(body).to match({
                              id: 1,
                              name: "Some company 10"
                            })
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: params }

    context 'valid form' do
      let(:params) { { name: 'new company name' } }

      it 'returns updates company' do
        expect(subject).to have_http_status(:ok)

        body = MultiJson.load(subject.body)
        expect(body['name']).to eq('new company name')

        expect(company.reload.name).to eq('new company name')
      end
    end

    context 'invalid form' do
      let(:params) { { name: nil } }

      it 'renders errors' do
        expect(subject).to have_http_status(:bad_request)
        body = MultiJson.load(response.body)

        expect(body).to eq({
                             'error' => 'RecordInvalidError',
                             'details' => "Validation failed: Name can't be blank"
                           })
      end
    end
  end
end
