# frozen_string_literal: true

# Library that contains all enteties can make some operations with them
class Library
  include Singleton
  include FileCreatable
  extend FileParsable

  attr_accessor :books, :authors, :orders, :readers

  # Loads all data to one object
  def load_all
    self.books = Book.all
    self.authors = Author.all
    self.orders = Order.all
    self.readers = Reader.all
  end

  def save_to_file(yaml_file_name = "library_#{file_number}")
    super
  end

  # Deletes all yaml files
  def self.delete_all_data
    %w[books authors orders readers].each do |dir_name|
      FileUtils.rm_rf("./data/#{dir_name}/.", secure: true)
    end
    puts 'All data deleted'
  end

  # Calculates statistics and shows top readers in terminal
  def show_top_readers(show_readers_count = 1)
    readers_statistics = create_statistics_hash(:reader_name, :book_title)
    show_top('readers', show_readers_count, readers_statistics)
  end

  # Calculates statistics and shows top books in terminal
  def show_most_popular_books(show_books_count = 1)
    books_statistics = create_statistics_hash(:book_title, :reader_name)
    show_top('books', show_books_count, books_statistics)
  end

  # Calculates statistics and shows top books uniq readers sum
  def show_most_popular_books_readers_count(books_count = 3)
    books_statistics = create_statistics_hash(:book_title, :reader_name)
    readers_count = count_most_popular_books_readers(books_statistics, books_count)
    puts "Top #{books_count} books have #{readers_count} readers"
  end

  private

  # Main - objects for which statistics is calculated (Book or Reader instance)
  # Counted - objects that we count for our statistics (Book or Reader instance)
  # Method accepts two symbols with methods names to make method reusable
  # Returns desc sorted hash with statistics
  def create_statistics_hash(get_main_obj_name, get_counted_obj_name)
    statistics_hash = Hash.new(0)
    insert_data_into_hash(statistics_hash, get_main_obj_name, get_counted_obj_name)
    statistics_hash.sort_by { |_name, uniq_count| uniq_count }.reverse.to_h
  end

  # Calculates quantity of unique counted objects for each main object and insert data to hash
  def insert_data_into_hash(statistics_hash, get_main_obj_name, get_counted_obj_name)
    uniq_main_names = orders.map(&get_main_obj_name).uniq
    uniq_main_names.each do |obj_name|
      main_obj_orders = orders.select { |order| order.public_send(get_main_obj_name) == obj_name }
      uniq_counted_obj_count = main_obj_orders.map(&get_counted_obj_name).uniq.count
      statistics_hash[obj_name] = uniq_counted_obj_count
    end
  end

  # Shows message about top books or readers depens on type
  def show_top(type, show_count, statistics_hash)
    show_count.times do |index|
      name = statistics_hash.keys[index]
      count = statistics_hash.values[index]
      serial_num = index + 1
      puts case type
           when 'books' then "Most popular book number #{serial_num} is #{name} - it has #{count} readers"
           when 'readers' then "Best reader number #{serial_num} is #{name} - read #{count} books"
           else 'Wrong type'
           end
    end
  end

  # Calculates top books uniq readers sum
  def count_most_popular_books_readers(books_statistics, books_count)
    books_titles = books_statistics.keys.slice(0, books_count)
    readers_names = []
    books_titles.each do |book_title|
      book_orders = orders.select { |order| order.book_title == book_title }
      readers_names += book_orders.map(&:reader_name)
    end
    readers_names.uniq.count
  end

  def file_number
    Dir['./data/libraries/*'].length + 1 || 1
  end
end
