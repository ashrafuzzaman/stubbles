source 'http://rubygems.org'

ruby '2.1.0'
gem 'rails', '~> 4.0.2'

group :assets do
  gem 'sass-rails', '~> 4.0.1'
  gem 'coffee-rails', '~> 4.0.1'
  #gem "jquery-fileupload-rails"

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'pg'
gem 'rolify'
gem 'sendgrid'
gem 'workflow'
gem 'acts-as-taggable-on', '~> 2.4.1'
gem "bootstrap-wysihtml5-rails", "~> 0.3.1.23"
gem 'simple_form'
gem 'awesome_print'
gem 'nested_form'
gem 'google_visualr', '~> 2.1.9'

group :assets do
  gem 'therubyracer', :platform => :ruby
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms => [:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rb-fchange', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-inotify', :require => false
  gem 'letter_opener' #to test email in development env. Usually stored in tmp/letter_opener
  gem 'rack-mini-profiler'
  gem 'ruby-growl'
  gem 'bullet'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
  gem 'ruby-prof'
  gem 'test-unit'
end

group :production do
  gem 'memcachier'
  gem 'dalli', '~>1.0.5'
  gem 'rails_12factor'
  gem 'foreman'
  gem 'puma'
end

gem "cache_digests"
gem 'unicorn'
gem 'less-rails-bootstrap'
gem 'auditlog', '0.0.2'
#gem 'auditlog', :path => '/home/jitu/projects/auditlog'
gem 'charter', :path => 'charter'

gem "rmagick"
gem "carrierwave"
gem 'remotipart', '1.0.5'
gem 'unf'
gem 'fog'
gem 'protected_attributes'
gem 'turbolinks'