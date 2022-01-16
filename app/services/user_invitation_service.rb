class UserInvitationService
  attr_reader :invite_email, :inviter

  def initialize(invite_email, inviter)
    @invite_email = invite_email
    @inviter = inviter
  end

  def call
    user_params = base_params.merge({ email: invite_email })
    user_params[:role] = 'worker'

    employee = inviter.company.users.new(user_params)
    employee.skip_confirmation!
    employee.save!
    EmployeesMailer.invite(employee.id).deliver_later

    employee
  end

  def base_params
    {
      password: "Aa1#{SecureRandom.hex}"
    }
  end
end
