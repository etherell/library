# frozen_string_literal: true

class Author
  include Saver
  include Validator

  attr_accessor :name, :biography

  def initialize(name, biography = '')
    @name = name
    @biography = biography
  end

  # Before save gets name as title for yaml file
  def save(yaml_file_name = name)
    super { validate_string!('name') }
  end
end
