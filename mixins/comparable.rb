module Comparable
  def ==(other)
    instance_variables.all? do |variable|
      instance_variable_get(variable) == other.instance_variable_get(variable)
    end
  end
end

