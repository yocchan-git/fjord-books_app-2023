# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    books_path
  end

  def after_update_path_for(_resource)
    user_path(current_user)
  end
end
