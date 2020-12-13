# frozen_string_literal: true

# Contains pesonal information about author
class Author
  include PropertyValidatable
  include FileCreatable
  extend FileParsable

  attr_accessor :name, :biography

  def initialize(name, biography = 'There\'s no information about the author')
    @name = name
    @biography = biography
    validate_string!(:name)
  end

  def save_to_file(yaml_file_name = name)
    super
  end

  def self.create_random
    new(Faker::Book.author).save_to_file
  end
end
