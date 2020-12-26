# frozen_string_literal: true

# Loads all necessary classes, mixins and extensions
require_relative 'preloader'

# Iniializes library and adds random data
library = Library.instance

# Calculates and shows statistics
puts library.count_top_readers(5).map { |reader_name, books| "#{reader_name} read #{books.count} books." }.join("\n")
puts library.count_top_books(5).map { |book_title, readers| "#{book_title} has #{readers.count} readers." }.join("\n")
puts library.show_top_books_readers_count
