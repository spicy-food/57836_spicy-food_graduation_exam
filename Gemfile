source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Rails本体
gem "rails", "~> 7.1.5.2"

# データベース
gem "pg", "~> 1.1"

# サーバー
gem "puma", ">= 5.0"

# 認証
gem "devise"
gem "omniauth-google-oauth2"

# 画像アップロード
gem "carrierwave"

# ページネーション
gem "kaminari"

# 国際化
gem "rails-i18n"

# バンドラー
gem "bootsnap", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]

  # テスト用のgem
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'shoulda-matchers'

  # RuboCop
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  # セキュリティ監査
  gem 'bundle-audit'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem 'letter_opener'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo"
  gem "tzinfo-data"
end

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# セキュリティ更新
gem "net-imap", "~> 0.5.7"
gem "nokogiri", ">= 1.18.8"
gem "rack", ">= 3.1.16"
gem "rack-session", ">= 2.1.1"
gem "importmap-rails"
gem "sprockets-rails"

# Sass関連のgem
gem 'sassc-rails'
gem 'sass-rails'