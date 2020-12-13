# frozen_string_literal: true

# Contains information about book, reader of this book
# and date when the book was taken
class Order
  include PropertyValidatable
  include FileCreatable
  extend FileParsable

  attr_accessor :book, :reader, :date

  def initialize(book, reader, date = Date.today)
    @book = book
    @reader = reader
    @date = date
    validate_props
  end

  def save_to_file(yaml_file_name = "#{book.title}_#{reader.name}")
    super
  end

  def self.create_random
    new(
      Book.all.sample,
      Reader.all.sample,
      Faker::Date.between(from: '2019-01-01', to: Date.today)
    ).save_to_file
  end

  def reader_name
    reader.name
  end

  def book_title
    book.title
  end

  private

  def validate_props
    %i[book reader date].each { |property_name| validate_instance!(property_name) }
  end
end
