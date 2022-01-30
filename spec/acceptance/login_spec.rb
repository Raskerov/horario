require 'spec_helper'

describe 'login', type: :feature, js: true do
  let!(:user) { create(:user, password: 'Password1234') }

  scenario 'login' do
    visit '/'
    expect(page.current_path).to eq('/auth/login')

    fill_in 'email', with: user.email
    fill_in 'password', with: 'something'
    click_button 'Zaloguj'

    # Not working, wrong credentials
    expect(page.current_path).to eq('/auth/login')

    fill_in 'password', with: 'Password1234'
    click_button 'Zaloguj'
    expect(page).to have_content('GRAFIK PRACY')

    find('.navigation-bar__nav-item', text: 'WYLOGUJ').click
    expect(page).to have_content('Witaj ponownie')

    visit '/'
    expect(page.current_path).to eq('/auth/login')
  end
end
