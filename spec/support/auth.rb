module Support
  module Auth
    def manual_login(user)
      expect(page).to have_content('Welcome back')
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Log in'
      expect(page).to have_content(user.full_name)
    end

    def login(user)
      login_as(user, scope: :user, run_callbacks: false)
    end

    def visit(url)
      page.visit(url)
      page.driver.wait_for_network_idle
    end
  end
end
