module TableauRestApi
  class Server < Base
    attr_reader :version, :build , :api_version

    def initialize(server)
      product_version = server.productVersion
      @version = product_version.value
      @build = product_version.build
      @api_version = server.restApiVersion 
    end
  end
end
