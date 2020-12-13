# frozen_string_literal: true
# frozen_string_literal: true

# Contains personal information about the reader
class Reader
  include PropertyValidatable
  include FileCreatable
  extend FileParsable

  attr_accessor :name, :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
    validate_props
  end

  def save_to_file(yaml_file_name = name)
    super
  end

  def self.create_random
    new(
      Faker::Name.name,
      Faker::Internet.email,
      Faker::Address.city,
      Faker::Address.street_name,
      Faker::Number.between(from: 1, to: 1000)
    ).save_to_file
  end

  private

  def validate_props
    string_params = %i[name email city street]
    string_params.each { |param| validate_string!(param) }
    validate_integer!(:house)
  end
end
