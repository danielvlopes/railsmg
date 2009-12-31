Haml::Template.options[:format] = :html5
Haml::Template.options[:attr_wrapper] = '"'

Sass::Plugin.options[:template_location] = "#{Rails.root}/app/sass"
Sass::Plugin.update_stylesheets

