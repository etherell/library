# frozen_string_literal: true

# Books that have authors
class Book
  include PropertyValidatable
  include FileCreatable
  extend FileParsable

  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
    validate_props
  end

  def save_to_file(yaml_file_name = title)
    super
  end

  def self.create_random
    new(Faker::Book.title, Author.all.sample).save_to_file
  end

  private

  def validate_props
    validate_string!(:title)
    validate_instance!(:author)
  end
end
