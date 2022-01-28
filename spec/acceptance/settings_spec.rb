require 'spec_helper'

describe 'profile', type: :feature, js: true do
  let(:company) { create(:company) }
  let!(:user) { create(:user, company: company, password: 'password1234', email: 'old@email.com') }

  before do
    login user
  end

  scenario 'password change' do
    visit '/app'
    visit '/app/settings/password'

    expect(page).to have_content('Podaj hasło')

    fill_in 'currentPassword', with: 'password1234'
    fill_in 'password', with: 'password1234321drowssap'
    fill_in 'passwordConfirmation', with: 'password1234321drowssap'

    click_button 'Zaktualizuj dane'

    expect(page.current_path).to eq('/app/settings/password')
  end

  context 'edit company name' do
    context 'user is an owner' do
      scenario 'can edit company name' do
        visit '/app/settings/company'

        fill_in 'name', with: 'Second Company Name'
        click_button 'Zaktualizuj dane'

        expect(user.company.reload.name).to eq('Second Company Name')
      end
    end

    context 'user is not owner' do
      let!(:user) { create(:user, :manager, company: company, password: 'password1234', email: 'old@email.com') }

      scenario 'cannot edit company name' do
        visit '/app/settings/profile'

        expect(page).not_to have_content('FIRMA')
      end
    end
  end
end
