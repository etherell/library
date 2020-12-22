class Order
  include PropertyValidatable
  extend JsonFilesManipulator::Parsable

  attr_reader :book, :reader, :date

  def initialize(book:, reader:, date: Date.today)
    @book = book
    @reader = reader
    @date = date
    validate_props!
  end

  def reader_name
    reader.name
  end

  def book_title
    book.title
  end

  private

  def validate_props!
    validate_instance_class!(book, Book)
    validate_instance_class!(reader, Reader)
    validate_instance_class!(date, Date)
  end
end
