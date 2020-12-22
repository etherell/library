class Book
  include PropertyValidatable
  extend JsonFilesManipulator::Parsable

  attr_reader :title, :author

  def initialize(title:, author:)
    @title = title
    @author = author
    validate_props!
  end

  private

  def validate_props!
    validate_string!(title)
    validate_instance_class!(author, Author)
  end
end
