class Reader
  include PropertyValidatable
  include Comparable
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

  private

  def validate_props!
    [name, email, city, street].each { |property| validate_string!(property) }
    validate_number!(house)
  end
end
