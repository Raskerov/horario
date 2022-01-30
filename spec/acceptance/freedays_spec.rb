require 'spec_helper'

describe 'freedays', type: :feature, js: true do
  let!(:company) { create(:company) }
  let!(:user) { create(:user, company: company) }
  let!(:worker1) { create(:user, :worker, company: company) }
  let!(:worker2) { create(:user, :worker, company: company) }
  let!(:freeday) { create(:freeday, user: worker1)}

  before do
    login user
  end

  scenario 'freedays feature' do
    visit '/app/schedule'
    expect(page).to have_content('Grafik pracy')

    find('.schedule__navbar__item', text: 'DNI WOLNE').click

    expect(page).to have_content(worker1.full_name)
    click_button('Akceptuj')

    expect(page).not_to have_content(worker1.full_name)
    click_button('Dodaj dzień wolny')

    expect(page).to have_content('Pracownik')
    page.all('.v-select')[1].click
    find('.vs__dropdown-option', text: 'L4').click

    page.all('.vc-svg-icon')[1].click
    sleep 1 # wait for animation to finish
    page.all('.day-1')[0].click
    page.all('.day-10')[0].click

    click_button('Dodaj')

    expect(page).to have_content(user.full_name)
    expect(page).to have_content('Zaakceptowany')

    click_button('Anuluj')
    expect(page).to have_content('Anulowany')
  end
end
