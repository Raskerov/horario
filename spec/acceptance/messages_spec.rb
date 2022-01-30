require 'spec_helper'

describe 'messages', type: :feature, js: true do
  let!(:company) { create(:company) }
  let!(:user) { create(:user, company: company) }
  let!(:worker) { create(:user, :worker, company: company) }
  let!(:worker2) { create(:user, :worker, company: company) }
  let!(:message) { create(:message, sender: worker2, receiver: user, text: 'Hello there')}

  before do
    login user
  end

  scenario 'sending and reading messages' do
    visit '/app/messages'
    expect(page).to have_content('Wiadomości')

    find('.messages__inbox__box', text: worker.full_name).click
    expect(page).not_to have_content('Hello there')
    expect(page).to have_field('message', placeholder: 'Napisz wiadomość i naciśnij Enter aby wysłać')

    fill_in 'message', with: 'Message text test, hello'
    find('.messages__conversation__input').native.send_keys(:return)

    expect(page).to have_content('Message text test, hello')
    expect(page).to have_field('message', with: '')

    # Second worker, no message shared with first one
    find('.messages__inbox__box', text: worker2.full_name).click
    expect(page).to have_field('message', placeholder: 'Napisz wiadomość i naciśnij Enter aby wysłać')
    expect(page).not_to have_content('Message text test, hello')
    expect(page).to have_content('Hello there')
  end
end
