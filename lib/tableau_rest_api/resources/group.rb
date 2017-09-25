module TableauRestApi
  class Group < Base
    attr_reader :id, :name 

    def initialize(group)
      @id = group.id
      @name = group.name
    end
  end
end
