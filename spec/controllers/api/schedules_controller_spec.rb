require 'spec_helper'

describe Api::SchedulesController do
  let(:company) { create(:company) }
  let!(:owner) { create(:user, email: 'some@email.com', company: company) }
  let!(:worker) { create(:user, :worker, company: company) }
  let!(:schedule1) { create(:schedule, company: company) }
  let!(:schedule2) { create(:schedule, :second_shift, company: company) }

  before do
    sign_in owner
  end

  describe 'GET #index' do
    subject { get :index }

    it 'return schedules' do
      expect(subject).to have_http_status(:ok)
      body = MultiJson.load(subject.body, symbolize_keys: true)
      expect(body).to match([{
                               id: schedule1.id,
                               name: schedule1.name,
                               start_hour: schedule1.start_hour,
                               end_hour: schedule1.end_hour,
                               user_ids: [],
                               weekdays: %w[monday tuesday wednesday thursday friday]
                             },
                             {
                               id: schedule2.id,
                               name: schedule2.name,
                               start_hour: schedule2.start_hour,
                               end_hour: schedule2.end_hour,
                               user_ids: [],
                               weekdays: %w[monday tuesday wednesday thursday friday]
                             }])
    end
  end

  describe 'GET #freedays' do
    subject { get :freedays, params: { id: schedule1.id } }
    let!(:user_schedule) { create(:user_schedule, user: worker, schedule: schedule1)}
    let!(:freeday1) { create(:freeday, user: worker, start_date: Time.parse('2022.01.25'), end_date: Time.parse('2022.02.02')) }

    it 'return schedules' do
      expect(subject).to have_http_status(:ok)
      body = MultiJson.load(subject.body, symbolize_keys: true)
      expect(body[0][:dates]).to eq("2022.01.25 - 2022.02.02")
      expect(body[0][:reason]).to eq("vacation")
      expect(body[0][:status]).to eq("requested")
      expect(body[0][:user][:id]).to eq(worker.id)
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context 'worker' do
      before do
        sign_in worker
      end
      let(:params) { {
        name: 'New schedule',
        start_hour: '06:00',
        end_hour: '14:00',
        user_ids: "#{owner.id},#{worker.id}",
        weekdays: 'monday,tuesday,wednesday,thursday'
      } }

      it 'creates freeday' do
        expect{ subject }.to change { Schedule.count }.by(1).and change { UserSchedule.count }.by(2)
        expect(subject).to have_http_status(:ok)

        body = MultiJson.load(subject.body, symbolize_keys: true)
        expect(body).to include({
                                  name: 'New schedule',
                                  start_hour: '06:00',
                                  end_hour: '14:00',
                                  user_ids: [owner.id, worker.id],
                                  weekdays: %w[monday tuesday wednesday thursday]
                              })
      end
    end
  end

  describe 'PUT #update' do
    subject { put :update, params: params }

    context 'reject' do
      let(:params) { {
        id: schedule1.id,
        name: 'New schedule',
        start_hour: '12:00',
        end_hour: '14:00',
        user_ids: "#{owner.id},#{worker.id}",
        weekdays: 'wednesday,thursday'
      } }

      it 'returns updates user' do
        expect(subject).to have_http_status(:ok)
        schedule1.reload
        expect(schedule1.start_hour).to eq('12:00')
        expect(schedule1.end_hour).to eq('14:00')
        expect(schedule1.weekdays).to eq(%w[wednesday thursday])
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: params }

    context 'valid form' do
      let(:params) { { id: schedule2.id } }

      it 'deletes schedule' do
        expect(subject).to have_http_status(:ok)

        expect(Schedule.where(id: schedule2.id).take).to be_nil
      end
    end
  end
end
