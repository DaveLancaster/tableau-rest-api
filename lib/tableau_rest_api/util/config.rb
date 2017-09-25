module TableauRestApi
  class Config
    attr_reader :options
    
    def initialize(config={})
      @options = {
        host: ENV['TABLEAU_HOST'] || 'https://tableau.lvh.me',
        api_version: '2.6',
        base: 'api',
        auth_duration: ENV['TABLEAU_AUTH_TOKEN_DURATION'] || 4.hours,
        credentials: {
          credentials: { 
            name: ENV['TABLEAU_USERNAME'] || 'admin',
            password: ENV['TABLEAU_PASSWORD'] || 'admin',
            site: { contentUrl: "" }
          }
        }
      }
      @options = @options.merge(config)
    end
  end
end
