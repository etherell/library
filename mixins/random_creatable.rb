module RandomCreatable
  def create_random(obj_name)
    case obj_name
    when 'author' then Author.new(**author_params)
    when 'book' then Book.new(**book_params)
    when 'order' then Order.new(**order_params)
    when 'reader' then Reader.new(**reader_params)
    else raise ArgumentError, 'Wrong object name'
    end
  end

  private

  def author_params
    { name: Faker::Book.author }
  end

  def book_params
    { title: Faker::Book.title, author: (authors.sample || create_random('author')) }
  end

  def order_params
    {
      book: (books.sample || create_random('book')),
      reader: (readers.sample || create_random('reader')),
      date: Faker::Date.between(from: '2019-01-01', to: Date.today)
    }
  end

  def reader_params
    {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      city: Faker::Address.city,
      street: Faker::Address.street_name,
      house: Faker::Number.between(from: 1, to: 1000)
    }
  end
end
