# frozen_string_literal: true

# Contains all necessary validations for objects
module PropertyValidatable
  private

  def validate_string!(property_name)
    not_a_string_error = "#{property_name.capitalize} can be only string"
    empty_string_error = "#{property_name.capitalize} can't be blank"
    property_value = public_send(property_name)

    raise ArgumentError, not_a_string_error unless property_value.is_a? String
    raise ArgumentError, empty_string_error if property_value.empty?

    true
  end

  def validate_instance!(property_name)
    klass = property_name.to_s.singularize.capitalize.constantize
    object = public_send(property_name)
    wrong_instance_class_error = "Wrond class of instance, you can pass only
                                 #{klass.name} but you pass #{object.class}"

    raise ArgumentError, wrong_instance_class_error unless object.is_a? klass

    true
  end

  def validate_integer!(property_name)
    not_an_integer_error = "#{property_name.capitalize} can be only integer"
    not_positive_integer_error = "#{property_name.capitalize} can be only positive"
    property_value = public_send(property_name)

    raise ArgumentError, not_an_integer_error unless property_value.is_a? Integer
    raise ArgumentError, not_positive_integer_error if property_value.negative?

    true
  end
end
