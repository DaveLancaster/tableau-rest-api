module TableauRestApi
  class User < Base
    attr_reader :id, :name, :site_role, :last_login 

    def initialize(user)
      @id = user.id
      @name = user.name
      @site_role = user.siteRole
      @last_login = user.lastLogin
    end
  end
end
