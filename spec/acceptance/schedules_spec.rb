require 'spec_helper'

describe 'schedules', type: :feature, js: true do
  let!(:company) { create(:company) }
  let!(:user) { create(:user, company: company) }
  let!(:worker1) { create(:user, :worker, company: company) }
  let!(:worker2) { create(:user, :worker, company: company) }
  let!(:schedule) { create(:schedule, company: company, name: 'Grafik testowy') }
  let!(:user_schedule) { create(:user_schedule, user: worker1, schedule: schedule) }

  before do
    login user
  end

  scenario 'schedule feature' do
    visit '/app/schedule'
    expect(page).to have_content('Grafik pracy')

    find('.schedule__navbar__item', text: 'PRZEGLĄD GRAFIKU').click

    expect(page).to have_content('Wybierz grafik')
    find('.property__value', text: 'Grafik testowy').click

    expect(page).to have_css('.vc-container')

    find('.schedule__navbar__item', text: 'STWÓRZ NOWY GRAFIK').click
    expect(page).to have_content('Nazwa grafiku')

    fill_in 'name', with: 'Nowy grafik'
    find(:css, "#monday").set(true)
    find(:css, "#tuesday").set(true)
    find(:css, "#worker_#{worker2.id}").set(true)
    click_button('Utwórz grafik')

    expect(page.current_path).to eq('/app/schedule/overview')
    expect(page).to have_content('Nowy grafik')

    find('.schedule__navbar__item', text: 'EDYTUJ ISTNIEJĄCE GRAFIKI').click
    expect(page).to have_content('Wybierz grafik')
    find('.property__value', text: 'Nowy grafik').click

    click_button('Usuń grafik')

    expect(page.current_path).to eq('/app/schedule/overview')
    expect(page).not_to have_content('Nowy grafik')
  end
end
