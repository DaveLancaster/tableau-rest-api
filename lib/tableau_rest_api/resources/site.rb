module TableauRestApi
  class Site < Base
    attr_reader :id, :name, :content_url 

    def initialize(site, called_by)
      @id = site.id
      @name = site.name
      @content_url = site.contentUrl
      @called_by = called_by
    end

    def users
      @called_by.users_on_site(@id)
    end

    def groups
      @called_by.groups(@id)
    end

    def datasources
      @called_by.datasources(@id)
    end
    
    def projects
      @called_by.query_projects(@id)
    end

    def workbooks
      @called_by.query_workbooks(@id)
    end

    def users_in_group(group_id)
      @called_by.users_in_group(@id, group_id)
    end

    def create_group(group)
      @called_by.create_group(@id, group)
    end

    def delete_group(group_id)
      @called_by.delete_group(@id, group_id)
    end

    def add_user_to_group(group_id, user_id)
      @called_by.add_user_to_group(@id, group_id, user_id)
    end

    def add_user_to_site(user)
      @called_by.add_user_to_site(@id, user)
    end

    def remove_user_from_group(group_id, user_id)
      @called_by.remove_user_from_group(@id, group_id, user_id)
    end

    def remove_user_from_site(user_id)
      @called_by.remove_user_from_site(@id, user_id)
    end

    def update_user(user)
      @called_by.update_user(@id, user)
    end

    def update_group(group)
      @called_by.update_group(@id, group)
    end
  end
end
