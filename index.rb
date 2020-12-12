require_relative 'preloader'

# Create authors
petro = Author.new('Petro')
valera = Author.new('Valera', 'Cool man')
lera = Author.new('Lera', 'Cool girl')
[petro, valera, lera].each(&:save)

# Create books
first_book = Book.new('First book', petro)
second_book = Book.new('Second book', valera)
third_book = Book.new('Third book', lera)
[first_book, second_book, third_book].each(&:save)

# Create readers
gosha = Reader.new("Gosha", "gosha@gmail.com", "GoshaLand", "SomeStreet", 27)
sasha = Reader.new("Sasha", "sasha@gmail.com", "Kiyv", "SomeStreet", 50)
mark = Reader.new("Mark", "mark@gmail.com", "Dnipro", "SomeStreet", 31)
[gosha, sasha, mark].each(&:save)

# Create orders
Order.new(first_book, gosha).save
Order.new(second_book, sasha, Date.today - 2).save
Order.new(third_book, mark, Date.today - 5).save

# Method to clean data
# Library.delete_all_data
