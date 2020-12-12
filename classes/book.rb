class Book
  include Saver
  include Validator

  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def save(yaml_file_name = title)
    super do
      validate_string!('title')
      validate_instance!('author')
    end
  end
end
