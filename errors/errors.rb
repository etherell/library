module Errors
  class WrongClass < StandardError
    attr_reader :expected, :real

    def initialize(expected:, real:)
      super
      @expected = expected
      @real = real
    end

    def message
      "Wrong entity class, expected: #{expected} got #{real}"
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
