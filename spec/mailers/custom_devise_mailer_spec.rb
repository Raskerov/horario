require 'spec_helper'

describe CustomDeviseMailer, type: :mailer do
  describe '#confirmation_instructions' do
    context 'new account' do
      subject { described_class.confirmation_instructions(user, 'token') }

      let(:user) { create(:user, :unconfirmed) }

      it 'has proper title, recipient and content' do
        expect(subject.subject).to eq("Potwierdź swoje konto!")
        expect(subject.to).to eq([user.email])
        expect(subject.from).to eq(['no-reply@horario'])
        expect(subject.body.encoded).to include('Kliknij poniżej żeby zacząć korzystać z Horario')
      end
    end

    context 'email change' do
      subject { described_class.confirmation_instructions(user, 'token', to: 'some@email.com') }

      let(:user) { create(:user, unconfirmed_email: 'some@email.com') }

      it 'has proper title, recipient and content' do
        expect(subject.subject).to eq("Potwierdź zmianę w swoim adresie e-mail")
        expect(subject.to).to eq(['some@email.com'])
        expect(subject.from).to eq(['no-reply@horario'])
        expect(subject.body.encoded).to include('Otrzymaliśmy zgłoszenie zmiany adresu email, kliknij poniżej aby potwierdzić')
      end
    end
  end

  describe '#reset_password_instructions' do
    subject { described_class.reset_password_instructions(user, 'token') }

    let(:user) { create(:user) }

    it 'has proper title, recipient and content' do
      expect(subject.subject).to eq("Reset hasła")
      expect(subject.to).to eq([user.email])
      expect(subject.from).to eq(['no-reply@horario'])
      expect(subject.body.encoded).to include("Otrzymaliśmy zgłoszenie resetu hasła, kliknij poniżej aby zresetować hasło")
    end
  end

  describe '#email_changed' do
    subject { described_class.email_changed(user) }

    let(:user) { create(:user) }

    it 'has proper title, recipient and content' do
      expect(subject.subject).to eq("Potwierdź zmianę w swoim adresie e-mail")
      expect(subject.to).to eq([user.email])
      expect(subject.from).to eq(['no-reply@horario'])
      expect(subject.body.encoded).to include("Otrzymaliśmy zgłoszenie zmiany adresu email")
    end
  end
end
