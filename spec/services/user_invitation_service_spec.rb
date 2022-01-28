require 'spec_helper'

describe UserInvitationService do

  describe '#call' do
    let(:company) { create(:company) }
    let(:user) { build_stubbed(:user, company: company) }
    let(:mailer_dbl) { double }

    subject do
      described_class.call(email, user)
    end

    context 'everything ok' do
      let(:email) { 'test@test.com' }

      it 'creates member and sends an email' do
        expect(EmployeesMailer).to receive(:invite).with(kind_of(Integer)).and_return(mailer_dbl)
        expect(mailer_dbl).to receive(:deliver_later)
        expect { subject }.to change { company.users.count }.by(1)
        expect(subject.email).to eq(email)
      end
    end
  end
end
