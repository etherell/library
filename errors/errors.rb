module Errors
  class WrongClass < StandardError
    def initialize(_msg = I18n.t('errors.wrong_class'))
      super
    end
  end

  class NotPositiveInteger < StandardError
    def initialize(msg = I18n.t('errors.negative_integer'))
      super
    end
  end

  class EmptyString < StandardError
    def initialize(msg = I18n.t('errors.empty_string'))
      super
    end
  end
end
