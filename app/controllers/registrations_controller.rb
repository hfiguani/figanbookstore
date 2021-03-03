class RegistrationsController < Devise::RegistrationsController
    def after_sign_up_path_for(user)
    new_profile_path(current_user)
  end
end
