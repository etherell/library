I18n.load_path << Dir["#{File.expand_path('./locales')}/*.yml"]
I18n.default_locale = :en
Linguistics.use :en
