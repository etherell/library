# frozen_string_literal: true

# Books that have authors
class Book
  include PropertyValidatable
  extend JsonFilesManipulator::Parsable

  attr_reader :title, :author

  def initialize(title:, author:)
    @title = title
    @author = author
    validate_props!
  end

  def validate_props!
    validate_string!(:title)
    validate_instance!(:author)
  end
end
