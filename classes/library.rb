class Library
  include Singleton
  include JsonFilesManipulator::Savable

  attr_reader :books, :authors, :orders, :readers

  def initialize
    @books = []
    @authors = []
    @orders = []
    @readers = []
    load_random_objects
  end

  def add(object)
    property_name = object.class.to_s.downcase.en.plural
    property = instance_variable_get("@#{property_name}")
    property ? (property << object) : (raise Errors::WrongClass)
    save_to_file
  end

  def show_top_readers(to_show_quantity = 1)
    top_readers = count_top_by(:reader_name, to_show_quantity)
    top_readers.map { |reader_name, books| "#{reader_name} read #{books.count} books." }.join("\n")
  end

  def show_top_books(to_show_quantity = 1)
    top_books = count_top_by(:book_title, to_show_quantity)
    top_books.map { |book_title, readers| "#{book_title} has #{readers.count} readers." }.join("\n")
  end

  def show_top_books_readers_count(to_show_quantity = 3)
    top_books = count_top_by(:book_title, to_show_quantity)
    readers_count = count_top_books_readers(top_books)
    "Top #{to_show_quantity} books have #{readers_count} readers"
  end

  private

  def load_random_objects(quantity = 50)
    %w[author book reader order].each do |obj_name|
      quantity.times { add(RandomFactory.create(obj_name)) }
    end
  end

  def count_top_by(property, to_show_quantity)
    @orders.group_by(&property)
           .sort_by { |_property, counted_objects| -counted_objects.count }
           .first(to_show_quantity).to_h
  end

  def count_top_books_readers(top_books)
    orders = top_books.values.flat_map(&:itself)
    orders.map(&:reader_name).uniq.count
  end
end
