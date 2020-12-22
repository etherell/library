# frozen_string_literal: true

# Loads all necessary classes, mixins and extensions
require_relative 'preloader'

# Iniializes library and adds random data
library = Library.instance

# Calculates and shows statistics
puts library.show_top_readers(5)
puts library.show_top_books(5)
puts library.show_top_books_readers_count
