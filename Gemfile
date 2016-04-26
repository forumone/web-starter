source 'https://rubygems.org'
gem 'capistrano', '3.4'
gem 'net-ssh', '~>2.9.2'
gem 'rake'
gem 'i18n', '0.6'
gem 'mime-types', '1.25.1'
gem 'tilt', '1.4'
gem 'mailcatcher', '0.5'
gem 'eventmachine', '0.12.10'
gem 'json'

# Load gem dependencies from the theme
theme_gemfile = File.join(File.dirname(__FILE__), "public/sites/all/themes/gesso/Gemfile")
if File.exists?(theme_gemfile)
  puts "Loading #{theme_gemfile} ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(theme_gemfile)
end
