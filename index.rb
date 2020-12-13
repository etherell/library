# frozen_string_literal: true

# Loads all necessary classes, mixins and extensions
require_relative 'preloader'

# Deletes all yaml files
Library.delete_all_data if Author.all.length > 100

# Creates random instances and saves them to yaml file
20.times { Author.create_random }
20.times { Book.create_random }
20.times { Reader.create_random }
20.times { Order.create_random }

# Sets library object, loads all data and saves to yaml
library = Library.instance
library.load_all
library.save_to_file

# Calculates and shows statistics
library.show_top_readers(5)
library.show_most_popular_books(5)
library.show_most_popular_books_readers_count(5)
