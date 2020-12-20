# frozen_string_literal: true

# Loads all necessary classes, mixins and extensions
require_relative 'preloader'

# Iniializes library and adds random data
library = Library.instance
library.add_random_objects

# Calculates and shows statistics
library.show_top_readers(5)
library.show_top_books(5)
library.show_top_books_readers_count(5)
