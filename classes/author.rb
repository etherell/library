class Author
  include PropertyValidatable
  extend JsonFilesManipulator::Parsable

  attr_reader :name, :biography

  def initialize(name:, biography: I18n.t('author.default_biography'))
    @name = name
    @biography = biography
    validate_props!
  end

  private

  def validate_props!
    [name, biography].each { |property| validate_string!(property) }
  end
end
