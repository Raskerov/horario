require 'spec_helper'

describe Api::MessagesController do
  let(:company) { create(:company) }
  let!(:owner) { create(:user, email: 'some@email.com', company: company) }
  let!(:worker) { create(:user, :worker, company: company) }
  let!(:first_message) { create(:message, sender: owner, receiver: worker, text: 'Welcome to app') }
  let!(:response_message) { create(:message, sender: worker, receiver: owner, text: 'Hello, it is nice to join') }

  before do
    sign_in owner
  end

  describe 'GET #conversation' do
    subject { get :conversation, params: { person_id: worker.id} }

    it 'return conversation' do
      expect(subject).to have_http_status(:ok)
      body = MultiJson.load(subject.body, symbolize_keys: true)
      expect(body.size).to eq(2)
      expect(body[0][:text]).to eq('Welcome to app')
      expect(body[0][:sender][:id]).to eq(owner.id)
      expect(body[1][:text]).to eq('Hello, it is nice to join')
      expect(body[1][:sender][:id]).to eq(worker.id)
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'all fine' do
      let(:params) { { message: 'Hello', receiver_id: worker.id } }

      it 'creates message' do
        expect{ subject }.to change { Message.count }.by(1)
        expect(subject).to have_http_status(:ok)
        expect(Message.last.sender_id).to eq(owner.id)
        expect(Message.last.text).to eq('Hello')
      end
    end
  end
end
