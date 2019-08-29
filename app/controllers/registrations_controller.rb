class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  private

  def check_captcha
    unless verify_recaptcha(action: 'login', minimum_score: 0.5)
      puts 'unverified token of recaptcha'
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      set_minimum_password_length
      respond_with users_session_url # render the sign up page
    end
  end
end
