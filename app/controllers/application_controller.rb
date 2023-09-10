class ApplicationController < ActionController::Base
  
  protected
  def devise_parameter_sanitizer # 新しいオプジェクトを作成または更新する際のパラメータ制御
    if resource_class == User then
      Users::ParameterSanitizer.new(User, :user, params) # クラスの新しいインスタンスを作成。:userはキーで、これに対応する許可する属性が定義されたハッシュを参照
    elsif resource_class == Teacher
      Teachers::ParameterSanitizer.new(Teacher, :teacher, params)
    else
      super #メソッドのオーバーライドの回避＝親クラス（Devise)と同名のメソッドを呼び出す。UserやTeacherクラス以外の場合は、デフォルトの設定が使用される
    end
  end
end
