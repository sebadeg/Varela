source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "http://github.com/#{repo_name}.git"
end

ruby '2.7.3' 

gem 'pg'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'coffee-script-source', '1.8.0'
gem 'font-awesome-rails'
gem 'bootstrap-sass'
gem 'sprockets', '~> 3.5', '>= 3.5.2'
gem 'jquery-turbolinks'

gem 'inherited_resources', '1.8'
gem 'rubyzip', '~> 1.2', '>= 1.2.2'

gem 'devise', '4.4.3'
#gem 'activeadmin', '1.3'
#gem 'responsive_active_admin', '0.0.5'
#gem 'active_skin', '0.0.12'
#gem 'activeadmin_addons', '1.6'
gem 'twitter-bootstrap-rails', '4.0'
gem 'devise-bootstrap-views', '0.0.11'

gem 'dbf', '~> 3.1', '>= 3.1.1'
gem 'roo', '~> 2.7', '>= 2.7.1'
gem 'roo-xls', '~> 1.2'
#gem 'afm', '~> 0.2.1'
#gem 'pdf-reader', '~> 2.0'
gem 'prawn', '~> 2.2', '>= 2.2.2'
#gem 'pdf-toolkit', '~> 1.1'
#gem 'cancancan', '~> 2.0'
gem 'combine_pdf', '~> 0.2.5'
gem 'chunky_png', '~> 1.3', '>= 1.3.10'
gem 'barby', '~> 0.6.5'

#gem 'geocoder', '~> 1.5'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
