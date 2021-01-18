require_relative 'preloader'

Library.new
library = Library.load
library.add(library.create_random('order'))
library.add(library.create_random('book'))
library.save
library = Library.load

top_readers = library.count_top_readers(5)
puts top_readers.map { |reader, books| I18n.t('top.readers', reader: reader.name, books_count: books.count) }
                .join("\n")

top_books = library.count_top_books(5)
puts top_books.map { |book, readers| I18n.t('top.books', book: book.title, readers_count: readers.count) }
              .join("\n")

top_books = library.top_books_readers_count(5)
puts I18n.t('top.books_readers_count', books_quantity: top_books[:quantity], readers_count: top_books[:readers_count])
