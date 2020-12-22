module PropertyValidatable
  private

  def validate_string!(property)
    validate_instance_class!(property, String)
    validate_string_presence!(property)
  end

  def validate_number!(property)
    validate_instance_class!(property, Integer)
    validate_integer_positivity!(property)
  end

  def validate_instance_class!(object, klass)
    raise Errors::WrongClass unless object.is_a? klass
  end

  def validate_string_presence!(property)
    raise Errors::EmptyString if property.empty?
  end

  def validate_integer_positivity!(property)
    raise Errors::NotPositiveInteger if property.negative?
  end
end
