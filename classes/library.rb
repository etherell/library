class Library
  SUPPORTED_CLASSES = [Author, Book, Order, Reader].freeze
  include YamlFilesManipulator::Savable
  extend YamlFilesManipulator::Parsable

  attr_reader :books, :authors, :orders, :readers

  def initialize
    @books = []
    @authors = []
    @orders = []
    @readers = []
    load_random_objects
  end

  def add(new_object)
    validate_instance_class!(new_object.class)
    add_nested_objects_from(new_object) if just_added?(new_object)
  end

  def count_top_readers(quantity = 1)
    count_top_by(:reader_name, quantity)
  end

  def count_top_books(quantity = 1)
    count_top_by(:book_title, quantity)
  end

  def top_books_readers_count(quantity = 3)
    top_books = count_top_by(:book_title, quantity)
    { quantity: quantity, readers_count: count_top_books_readers(top_books) }
  end

  private

  def load_random_objects(quantity = 30)
    %w[author book reader order].each do |obj_name|
      quantity.times { add(RandomFactory.create(obj_name)) }
      save_to_file
    end
  end

  def count_top_by(property, quantity)
    orders.group_by(&property)
          .max_by(quantity) { |_property, orders| orders.count }
          .to_h
  end

  def count_top_books_readers(top_books)
    orders = top_books.values.flat_map(&:itself)
    orders.map(&:reader_name).uniq.count
  end

  def just_added?(new_object)
    property_name = new_object.class.to_s.downcase.en.plural
    property = instance_variable_get("@#{property_name}")
    return false if property.any? { |object| object == new_object }

    property << new_object
    true
  end

  def add_nested_objects_from(object)
    object.instance_variables.each do |variable|
      property = object.instance_variable_get(variable)
      add(property) if SUPPORTED_CLASSES.include? property.class
    end
  end

  def validate_instance_class!(object_class)
    return if SUPPORTED_CLASSES.include?(object_class)

    raise Errors::WrongClass.new(expected: SUPPORTED_CLASSES, real: object_class)
  end
end
