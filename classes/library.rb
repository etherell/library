require 'fileutils'

class Library
  include Saver
  include Validator

  attr_accessor :books, :authors, :orders, :readers

  def initialize(books = [], authors = [], orders = [], readers = [])
    @books = books
    @authors = authors
    @orders = orders
    @readers = readers
  end

  def save
    super do
      collections_names = %w[books authors orders readers]
      collections_names.each do |collection_name|
        objects_collection = public_send(collection_name)

        objects_collection.each { |object| validate_instance!(collection_name.singularize) }
      end
    end
  end

  def self.delete_all_data
    %w[books authors orders readers].each do |dir_name|
      FileUtils.rm_rf("./data/#{dir_name}/.", secure: true)
    end
    puts 'All data deleted'
  end
end
