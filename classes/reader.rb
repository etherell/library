class Reader
  include Saver
  include Validator

  attr_accessor :name, :email, :city, :street, :house

  def initialize(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  def save(yaml_file_name = name)
    super do
      string_params = %w[name email city street]
      string_params.each { |param| validate_string!(param) }
      validate_integer!('house')
    end
  end
end
