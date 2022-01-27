require 'spec_helper'

describe Api::EmployeesController do
  let(:company) { create(:company) }
  let!(:owner) { create(:user, email: 'some@email.com', company: company) }
  let!(:worker) { create(:user, :worker, company: company) }

  before do
    sign_in owner
  end

  describe 'GET #index' do
    subject { get :index }

    it 'return user data' do
      expect(subject).to have_http_status(:ok)
      body = MultiJson.load(subject.body, symbolize_keys: true)
      expect(body).to match([{:company=>company.name,
                              :email=>"some@email.com",
                              :full_name=>owner.full_name,
                              :id=>owner.id,
                              :joined=>true,
                              :role=>"owner"},
                             {:company=>company.name,
                              :email=>worker.email,
                              :full_name=>worker.full_name,
                              :id=>worker.id,
                              :joined=>true,
                              :role=>"worker"}])
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'valid form' do
      let(:params) { { email: 'newuser@useroo.com' } }

      it 'invites user' do
        expect(UserInvitationService).to receive(:call).with(params[:email], owner)

        expect(subject).to have_http_status(:ok)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params }

    context 'valid form' do
      let(:params) { { id: worker.id } }

      it 'deletes user' do
        expect(subject).to have_http_status(:ok)

        expect(User.where(id: worker.id).take).to be_nil
      end
    end

    context 'self delete' do
      let(:params) { { id: owner.id } }

      it 'doesnt delete user' do
        expect(subject).to have_http_status(:forbidden)

        expect(User.where(id: owner.id).take).to_not be_nil
      end
    end
  end

  describe 'PUT #change_role' do
    subject { put :change_role, params: params }

    context 'valid form' do
      let(:params) { { id: worker.id, role: 'manager' } }

      it 'returns updates user' do
        expect(subject).to have_http_status(:ok)

        expect(worker.reload.role).to eq('manager')
      end
    end
  end
end
