module TableauRestApi
  class ApiError < StandardError
    def initialize(error)
      super(error)
    end
  end
end
