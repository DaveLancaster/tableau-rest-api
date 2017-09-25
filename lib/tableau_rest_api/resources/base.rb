module TableauRestApi
  class Base
    def to_hash
      self.to_array.to_h
    end
    
    def to_h
      self.to_hash
    end

    def to_array
      filter_instance_variables.map do |var|
        [Helpers::camel_case_lower(var[1..-1]).to_sym, self.instance_variable_get(var)]
      end
    end

    private

    def filter_instance_variables
      self.instance_variables.select { |var| var != :@called_by }
    end
  end
end

