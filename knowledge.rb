class Module
  def attribute(arg, &block)
    if arg.kind_of? Hash
      arg, value = arg.to_a.first
    else
      value = nil
    end
    var = "@#{arg}".to_sym
    define_method("#{arg}") do
      if instance_variables.include? var
        instance_variable_get(var)
      else
        if block_given?
          instance_variable_set(var, instance_eval(&block))
        else
          instance_variable_set(var, value)
        end       
      end
    end
    define_method("#{arg}=") { instance_variable_set(var, v) }
    define_method("#{arg}?") { instance_variable_get(var) }   
  end
end