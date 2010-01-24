if RAILS_ENV == "test"

  require 'remarkable_activerecord'

  # Available Locales
  Remarkable.add_locale RAILS_ROOT + "/vendor/plugins/remarkable_paperclip/locales/en.yml"
  Remarkable.add_locale RAILS_ROOT + "/vendor/plugins/remarkable_paperclip/locales/pt-BR.yml"

  require File.join(File.dirname(__FILE__), "lib", "remarkable_paperclip")

  require 'spec'
  require 'spec/rails'

  Remarkable.include_matchers!(Remarkable::Paperclip, Spec::Rails::Example::ModelExampleGroup)

end
