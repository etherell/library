require_relative 'preloader'

library = Library.new

top_readers = library.count_top_readers(5)
puts top_readers.map { |name, books| I18n.t('top.readers', reader_name: name, books_count: books.count) }
                .join("\n")

top_books = library.count_top_books(5)
puts top_books.map { |title, readers| I18n.t('top.books', book_title: title, readers_count: readers.count) }
              .join("\n")

top_books = library.top_books_readers_count(5)
puts I18n.t('top.books_readers_count', books_quantity: top_books[:quantity], readers_count: top_books[:readers_count])
