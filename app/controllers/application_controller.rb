class ApplicationController < ActionController::Base
  # before_action :basic_auth # basic認証
  before_action :configure_permitted_parameters, if: :devise_controller? # strong parameter

  private

  # 重要！master.keyのコピーを忘れず、外部開発環境のパソコンでbasic認証ができなかったので、一旦basic認証を削除。
  # 帰宅後、マージするとき、現状復旧します。20221106 17:15

  # basic認証1015////////
  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
  #     # username == 'hello' && password == 'techcamp'//環境変数設定済み1016
  #   end
  # end
  # basic認証ここまで1015////////

  # strong parameter
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name_kanji, :first_name_kanji, :last_name_kana, :first_name_kana, :birthday]) # 複数のパラメーターを送る際の記述
  end
end
