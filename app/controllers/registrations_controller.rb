class RegistrationsController < Devise::RegistrationsController
  def create
    if Rails.env.production?
      if verify_recaptcha
        super
      else
        build_resource(sign_up_params)
        clean_up_passwords(resource)
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
        flash.delete :recaptcha_error
        render :new
      end
    else
      super
    end
  end
end