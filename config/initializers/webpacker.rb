# クライアントサイドで環境変数を読み込める為、Webpacker導入
# % touch config/initializers/webpacker.rb
Webpacker::Compiler.env["PAYJP_PUBLIC_KEY"] = ENV["PAYJP_PUBLIC_KEY"]
