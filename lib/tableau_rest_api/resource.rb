module TableauRestApi
  # Subclass providing access to Tableau resources.
  # An auth token is requested if missing or expired.
  class Resource < Client
    aspector do
      before :sites, :login
      before :create_site, :login
      before :switch_site, :login
      before :delete_site, :login
    end

    include TableauRestApi::UserGroup
    include TableauRestApi::WorkbookDatasource
    include TableauRestApi::ScheduleSubscription

    def server_info
      url = build_url 'serverinfo'
      Server.new((get url).serverInfo)
    end

    def sites
      resp = get build_url('sites')
      sites = extract_sites(resp)
      sites = retrieve_additional_pages(resp, sites, 'sites', :extract_sites) 
    end
 
    def create_site(site)
      url = build_url 'sites'
      Site.new((post url, site).site, self)
    end

    def switch_site(site)
      url = build_url ['auth', 'switchSite']
      @token = Token.new((post url, site).credentials.token, self.config[:auth_duration])
    end

    def delete_site(site_id)
      url = build_url ['sites', site_id]
      delete url
      @token = nil
    end

    private

    def extract_sites(response)
      response.sites.site.to_a.map { |site| Site.new(site, self) }
    end
 end
end
