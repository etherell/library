# frozen_string_literal: true

# Contains information about book, reader of this book
# and date when the book was taken
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

  def validate_props!
    %i[book reader date].each { |property_name| validate_instance!(property_name) }
  end
end
