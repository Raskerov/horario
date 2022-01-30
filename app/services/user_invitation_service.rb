class UserInvitationService
  def self.call(invite_email, inviter)
    user_params = base_params.merge({ email: invite_email })
    user_params[:role] = 'worker'

    employee = inviter.company.users.new(user_params)
    employee.skip_confirmation_notification!
    employee.save!
    EmployeesMailer.invite(employee.id).deliver_later

    employee
  end

  def self.base_params
    {
      password: "Aa1#{SecureRandom.hex}"
    }
  end
end
