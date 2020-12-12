class Order
  include Saver
  include Validator

  attr_accessor :book, :reader, :date

  def initialize(book, reader, date = Date.today)
    @book = book
    @reader = reader
    @date = date
  end

  def save(yaml_file_name = "#{book.title}_#{reader.name}")
    super do
      %w[book reader date].each { |property_name| validate_instance!(property_name) }
    end
  end
end
