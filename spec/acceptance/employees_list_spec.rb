require 'spec_helper'

describe 'employee list', type: :feature, js: true do
  let!(:company) { create(:company) }
  let!(:user) { create(:user, company: company) }
  let!(:manager) { create(:user, :manager, company: company) }
  let!(:worker) { create(:user, :worker, company: company) }

  before do
    login user
  end

  scenario 'employee list view, inviting new users' do
    visit '/app/employees'
    expect(page).to have_content('Lista pracowników')
    expect(page).to have_content(user.full_name)
    expect(page).to have_content('Właściciel')
    expect(page).to have_content(manager.full_name)
    expect(page).to have_content('Manager')
    expect(page).to have_content(worker.full_name)
    expect(page).to have_content('Pracownik')
    expect(page).to have_content(user.email)
    expect(page).to have_content(manager.email)
    expect(page).to have_content(worker.email)
    expect(page).not_to have_content('Zaproszony pracownik')
    expect(page).not_to have_content('newuser@horario.pl')

    fill_in 'email', with: 'newuser@horario.pl'
    click_button 'Dodaj'

    expect(page).to have_content('Zaproszony pracownik')
    expect(page).to have_content('newuser@horario.pl')

    # Delete user
    # click_button(class: '.button', text: 'Usuń', id: "delete_#{manager.id}")
    click_button('Usuń', id: "delete_#{manager.id}")

    expect(page).not_to have_content(manager.full_name)
    expect(page).not_to have_content(manager.email)
  end
end
