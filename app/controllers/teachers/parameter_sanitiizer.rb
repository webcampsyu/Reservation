class Teachers::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super #親クラス（Deviseのデフォルトの設定）の同名メソッドを呼び出す
    permit(:sign_up, keys: [:teacher_name, :teacher_area])
  end
end
