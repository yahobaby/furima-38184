class ApplicationController < ActionController::Base
  #basic認証1015////////
  before_action :basic_auth


  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
      # username == 'hello' && password == 'techcamp'//環境変数設定済み1016
    end
  end
  #basic認証ここまで1015////////

end
