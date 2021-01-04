class Library
  SUPPORTED_CLASSES = [Author, Book, Order, Reader].freeze
  PERMITTED_CLASSES = [Author, Book, Library, Order, Reader, Date].freeze
  DATA_PATH = './data/library.yaml'.freeze
  DIR_NAME = 'data'.freeze

  include RandomCreatable
  attr_reader :books, :authors, :orders, :readers

  def initialize
    @books = []
    @authors = []
    @orders = []
    @readers = []
    add_random_objects
    save
  end

  def add(new_object)
    validate_instance_class!(new_object.class)
    add_nested_objects_from(new_object) if just_added?(new_object)
  end

  def count_top_readers(quantity = 1)
    count_top_by(:reader, quantity)
  end

  def count_top_books(quantity = 1)
    count_top_by(:book, quantity)
  end

  def top_books_readers_count(quantity = 3)
    top_books = count_top_by(:book, quantity)
    { quantity: quantity, readers_count: count_top_books_readers(top_books) }
  end

  def save
    Dir.mkdir(DIR_NAME) unless Dir.exist?(DIR_NAME)
    File.open(DATA_PATH, 'w+') { |file| file.write(Psych.dump(self)) }
  end

  def self.load
    YAML.safe_load(File.read(DATA_PATH), permitted_classes: PERMITTED_CLASSES, aliases: true)
  end

  private

  def add_random_objects(quantity = 50)
    %w[author book reader order].each do |obj_name|
      quantity.times { add(create_random(obj_name)) }
    end
  end

  def count_top_by(property, quantity)
    orders.group_by(&property)
          .max_by(quantity) { |_property, orders| orders.count }
          .to_h
  end

  def count_top_books_readers(top_books)
    orders = top_books.values.flat_map(&:itself)
    orders.map(&:reader).uniq.count
  end

  def just_added?(new_object)
    property_name = new_object.class.to_s.downcase.en.plural
    property = instance_variable_get("@#{property_name}")
    return false if property.include?(new_object)

    property << new_object
    true
  end

  def add_nested_objects_from(object)
    object.instance_variables.each do |variable|
      nested_obj = object.instance_variable_get(variable)
      add(nested_obj) if SUPPORTED_CLASSES.include?(nested_obj.class)
    end
  end

  def validate_instance_class!(object_class)
    return if SUPPORTED_CLASSES.include?(object_class)

    raise Errors::WrongClass.new(expected: SUPPORTED_CLASSES, real: object_class)
  end
end
