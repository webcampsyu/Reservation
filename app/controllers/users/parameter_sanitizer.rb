class Users::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:user_name, :user_area, :curriculum])
  end
end