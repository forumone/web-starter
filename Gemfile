source 'https://rubygems.org' do
  gem 'capistrano', '~>3.1'
  gem 'rake'
end

# Load gem dependencies from the theme
theme_gemfile = File.join(File.dirname(__FILE__), "public/sites/all/themes/gesso/Gemfile")
if File.exists?(theme_gemfile)
  puts "Loading #{theme_gemfile} ..." if $DEBUG # `ruby -d` or `bundle -v`
  instance_eval File.read(theme_gemfile)
end
