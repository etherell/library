# frozen_string_literal: true
# frozen_string_literal: true

# Contains personal information about the reader
class Reader
  include PropertyValidatable
  extend JsonFilesManipulator::Parsable

  attr_reader :name, :email, :city, :street, :house

  def initialize(name:, email:, city:, street:, house:)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
    validate_props!
  end

  def validate_props!
    string_params = %i[name email city street]
    string_params.each { |param| validate_string!(param) }
    validate_integer!(:house)
  end
end
