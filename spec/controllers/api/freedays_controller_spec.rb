require 'spec_helper'

describe Api::FreedaysController do
  let(:company) { create(:company) }
  let!(:owner) { create(:user, email: 'some@email.com', company: company) }
  let!(:manager) { create(:user, :manager, company: company) }
  let!(:worker) { create(:user, :worker, company: company) }
  let!(:freeday) { create(:freeday, user: worker, start_date: Time.parse('2022.01.25'), end_date: Time.parse('2022.02.02'))}

  before do
    sign_in owner
  end

  describe 'GET #index' do
    subject { get :index }

    it 'return freedays' do
      expect(subject).to have_http_status(:ok)
      body = MultiJson.load(subject.body, symbolize_keys: true)
      expect(body).to match([{
                               :id => freeday.id,
                               :user => {
                                 :id => worker.id,
                                 :full_name => worker.full_name
                               },
                               :dates => "2022.01.25 - 2022.02.02",
                               :status => "requested",
                               :status_label => "requested",
                               :reason => "vacation"
                             }])
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'worker' do
      before do
        sign_in worker
      end
      let(:params) { { user_id: worker.id, reason: 'vacation', start_date: Time.parse('2022.01.25'), end_date: Time.parse('2022.02.02')  } }

      it 'creates freeday' do
        expect{ subject }.to change { Freeday.count }.by(1)
        expect(subject).to have_http_status(:ok)
        body = MultiJson.load(subject.body, symbolize_keys: true)
        expect(body).to include({
                                  dates: "2022.01.25 - 2022.02.02",
                                  reason: "vacation",
                                  status: "requested",
                                  user: { full_name: worker.full_name, id: worker.id }
                              })
      end
    end

    context 'managing person creates' do
      let(:params) { { user_id: worker.id, reason: 'vacation', start_date: Time.parse('2022.01.25'), end_date: Time.parse('2022.02.02')  } }

      it 'creates freeday' do
        expect{ subject }.to change { Freeday.count }.by(1)
        expect(subject).to have_http_status(:ok)
        body = MultiJson.load(subject.body, symbolize_keys: true)
        expect(body).to include({
                                  dates: "2022.01.25 - 2022.02.02",
                                  reason: "vacation",
                                  status: "accepted",
                                  user: { full_name: worker.full_name, id: worker.id }
                                })
      end
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: params }

    context 'reject' do
      let(:params) { { id: freeday.id, status: 'rejected' } }

      it 'returns updates user' do
        expect(subject).to have_http_status(:ok)
        freeday.reload
        expect(freeday.status).to eq('rejected')
        expect(freeday.rejected_by).to eq(owner)
      end
    end

    context 'accept' do
      let(:params) { { id: freeday.id, status: 'accepted' } }

      it 'returns updates user' do
        expect(subject).to have_http_status(:ok)
        freeday.reload
        expect(freeday.status).to eq('accepted')
        expect(freeday.accepted_by).to eq(owner)
      end
    end
  end
end
