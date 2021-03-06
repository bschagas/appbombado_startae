class AppbombadoGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :app_name, :type => :string, :default => "app"

def generate_appbombado

  remove_file "Gemfile"
  copy_file "Gemfile"
  
  run "bundle update"
  run "bundle install"
   


  remove_file "config/database.yml"
  template "database.yml", "config/database.yml"
  run "rake db:create"

  copy_file ".bowerrc"

  run "bundle exec guard init"

  run "rails g start:slim"

  run "rails g start:heroku"
  run "rails g start:heroku_wake_up"
  run "rails g start:unicorn"

  run "rails g start:locales"


  application do
   "config.i18n.default_locale = 'pt-BR'
    config.time_zone = 'Brasilia'

    config.generators do |g|
      g.assets            false
      g.helper            false
      g.test_framework    nil
    end"
  end

  run "rails g simple_form:install --bootstrap"
  remove_file "config/initializers/simple_form_bootstrap.rb"
  copy_file "simple_form_bootstrap.rb", "config/initializers/simple_form_bootstrap.rb"

  copy_file "better_errors.rb", "config/initializers/better_errors.rb"

  remove_file "app/views/layouts/application.html.erb"
  template "application.html.slim", "app/views/layouts/application.html.slim"

  remove_file "app/assets/javascripts/application.js"
  copy_file "application.coffee", "app/assets/javascripts/application.coffee"

  remove_file "app/assets/stylesheets/application.css"
  copy_file "application.sass", "app/assets/stylesheets/application.sass"

  copy_file "layout.sass", "app/assets/stylesheets/layout.sass"

  run "bower install bootstrap"
  run "bower install bourbon"
  run "bower install animate.css"

  run "rails g controller home index"

  route "root 'home#index'"

  end

  def file_name
    app_name.underscore
  end

end

