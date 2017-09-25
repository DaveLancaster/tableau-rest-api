module TableauRestApi
  class Response
    def initialize(resp)
      @body = resp.body
    end

    def parse
      @body.length >= 2 ? JSON::parse(@body, object_class: OpenStruct) : nil
    end
  end
end
