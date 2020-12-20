# frozen_string_literal: true

# Contains pesonal information about author
class Author
  include PropertyValidatable
  extend JsonFilesManipulator::Parsable

  attr_reader :name, :biography

  def initialize(name:, biography: 'Information is absent')
    @name = name
    @biography = biography
    validate_props!
  end

  def validate_props!
    validate_string!(:name)
    validate_string!(:biography)
  end
end
