module TableauRestApi
  # Client class wrapping a subset of the Tableau Rest API
  # This class just contains worker methods for interacting with Tableau.
  # See the Request sub-class for resource requests.
  class Client
    attr_reader :config, :token

    include TableauRestApi::Pagination
    
    def initialize
      @config = Config.new.options
    end

    def configure(config)
      @config = Config.new(config).options
    end

    def login(*_args)
      return if authorised?
      url = build_url ['auth', 'signin']
      resp = post url, @config[:credentials]
      @token = Token.new(resp.credentials.token, @config[:auth_duration])
    end

    def logout
      post(build_url ['auth', 'signout'])
      @token = nil
      !authorised?
    end

    def authorised?
      token = self.token
      token && !token.expired? ? true : false
    end
    
    private

    def header(boundary=nil)
      head = { :accept => :json, :content_type => :json }
      head = authorised? ? head.merge({ :x_tableau_auth => self.token.value }) : head
      head = boundary ? head.merge({ :content_type => "multipart/mixed; boundary=#{boundary}"}) : head
    end

    def build_url(endpoint, page=nil)
      endpoint = endpoint.is_a?(Array) ? endpoint.join('/') : endpoint
      url = "#{@config[:host]}/#{@config[:base]}/#{@config[:api_version]}/#{endpoint}"
      url = page ? url + "?pageNumber=#{page}" : url
    end

    def get(url)
      Response.new(RestClient.get(url, header)).parse
    end
    
    def post(url, data={}, boundary=nil)
      data = data.to_json unless boundary
      headers = header boundary
      Response.new(RestClient.post(url, data, headers)).parse
    end
    
    def put(url, data={})
      Response.new(RestClient.put(url, data.to_json, header)).parse
    end
    
    def delete(url)
      Response.new(RestClient.delete(url, header)).parse
    end

    def fetch_paginated_set(endpoint, extract)
      response = get build_url(endpoint)
      collection = extract.call(response)
      collection = retrieve_additional_pages(response, collection, endpoint, extract) 
    end
 end
end
