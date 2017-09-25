module TableauRestApi
  class Datasource < Base
    attr_reader :id, :name, :type, :created_at

    def initialize(ds)
      @id = ds.id
      @name = ds.name
      @type = ds.type
      @created_at = ds.createdAt
    end
  end
end
