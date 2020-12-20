# frozen_string_literal: true

# Library that contains all enteties can make some operations with them
class Library
  include Singleton
  include JsonFilesManipulator::Savable

  attr_accessor :books, :authors, :orders, :readers

  def initialize
    @books = []
    @authors = []
    @orders = []
    @readers = []
  end

  def add_random(obj_name)
    property_name = obj_name.pluralize

    public_send(property_name) << RandomFactory.create(obj_name)
    save_to_file
  end

  def add_random_objects(quantity = 30)
    %w[author book reader order].each do |obj_name|
      quantity.times { add_random(obj_name) }
    end
    puts "Added to library #{quantity} objects of each type"
  end

  def show_top_readers(show_readers_count = 1)
    top_readers_stats_hash = create_top_stats_hash(:reader_name, :book_title)
    show_top('readers', show_readers_count, top_readers_stats_hash)
  end

  def show_top_books(show_books_count = 1)
    top_books_stats_hash = create_top_stats_hash(:book_title, :reader_name)
    show_top('books', show_books_count, top_books_stats_hash)
  end

  def show_top_books_readers_count(books_count = 3)
    top_books_stats_hash = create_top_stats_hash(:book_title, :reader_name)
    readers_count = count_top_books_readers(top_books_stats_hash, books_count)
    puts "Top #{books_count} books have #{readers_count} readers"
  end

  private

  # main - objects for which statistics is calculated (Book or Reader instance)
  # counted - objects that we count for our statistics (Book or Reader instance)
  def create_top_stats_hash(get_main_obj_name, get_counted_obj_name)
    top_stats_hash = Hash.new(0)
    insert_data_into_hash(top_stats_hash, get_main_obj_name, get_counted_obj_name)
    sort_hash_desc(top_stats_hash)
  end

  # Calculates quantity of unique counted objects for each main object and insert data to hash
  def insert_data_into_hash(top_stats_hash, get_main_obj_name, get_counted_obj_name)
    uniq_main_names = orders.map(&get_main_obj_name).uniq
    uniq_main_names.each do |main_obj_name|
      main_obj_orders = orders.select { |order| order.public_send(get_main_obj_name) == main_obj_name }
      uniq_counted_names = main_obj_orders.map(&get_counted_obj_name).uniq
      top_stats_hash[main_obj_name] = uniq_counted_names.count
    end
  end

  def sort_hash_desc(top_stats_hash)
    top_stats_hash.sort_by { |_name, uniq_count| uniq_count }.reverse.to_h
  end

  # Shows message about top books or readers depens on type
  def show_top(type, show_count, top_stats_hash)
    show_count.times do |index|
      obj_name = top_stats_hash.keys[index]
      count = top_stats_hash.values[index]
      serial_num = index + 1
      puts case type
           when 'books' then "Most popular book number #{serial_num} is #{obj_name} - it has #{count} readers"
           when 'readers' then "Best reader number #{serial_num} is #{obj_name} - read #{count} books"
           else 'Wrong type'
           end
    end
  end

  # Calculates top books uniq readers sum
  def count_top_books_readers(top_books_stats_hash, books_count)
    books_titles = top_books_stats_hash.keys.slice(0, books_count)
    readers_names = []
    books_titles.each do |book_title|
      book_orders = orders.select { |order| order.book_title == book_title }
      readers_names += book_orders.map(&:reader_name)
    end
    readers_names.uniq.count
  end
end
