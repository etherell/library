class Library
  SUPPORTED_CLASSES = [Author, Book, Order, Reader].freeze
  NESTED_CLASSES = [Author, Book, Reader].freeze
  CLASSES_WITH_NESTED = [Order, Book].freeze

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

  def add(new_object)
    validate_object_class!(new_object.class)
    add_nested_objects_from(new_object) if just_added?(new_object)
  end

  def count_top_readers(to_show_quantity = 1)
    count_top_by(:reader_name, to_show_quantity)
  end

  def count_top_books(to_show_quantity = 1)
    count_top_by(:book_title, to_show_quantity)
  end

  def show_top_books_readers_count(to_show_quantity = 3)
    top_books = count_top_by(:book_title, to_show_quantity)
    readers_count = count_top_books_readers(top_books)
    "Top #{to_show_quantity} books have #{readers_count} readers"
  end

  private

  def load_random_objects(quantity = 2)
    %w[author book reader order].each do |obj_name|
      quantity.times { add(RandomFactory.create(obj_name)) }
      save_to_file
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

  def just_added?(new_object)
    property_name = new_object.class.to_s.downcase.en.plural
    property = instance_variable_get("@#{property_name}")
    return false if property.any? { |object| object == new_object }
    return true if property << new_object
  end

  def add_nested_objects_from(object)
    return unless CLASSES_WITH_NESTED.include? object.class

    object.instance_variables.each do |variable|
      property = object.instance_variable_get(variable)
      add(property) if NESTED_CLASSES.include? property.class
    end
  end

  def validate_object_class!(object_class)
    return if SUPPORTED_CLASSES.include?(object_class)

    raise Errors::WrongClass.new(expected: SUPPORTED_CLASSES, real: object_class)
  end
end
