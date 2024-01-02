# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
