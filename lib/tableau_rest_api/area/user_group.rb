module TableauRestApi
  module UserGroup
    aspector do
      before :users_on_site,:login
      before :groups, :login
      before :users_in_group, :login
      before :add_user_to_site, :login
      before :add_user_to_group, :login
      before :create_group, :login
      before :delete_group, :login
      before :remove_user_from_group, :login
      before :remove_user_from_site, :login
      before :update_user, :login
      before :update_group, :login
    end
 
    def users_on_site(site_id)
      url = build_url ['sites', site_id, 'users']
      (get url).users.user.to_a.map { |user| User.new(user) }
    end

    def groups(site_id)
      url = build_url ['sites', site_id, 'groups']
      (get url).groups.group.to_a.map { |group| Group.new(group) }
    end

    def users_in_group(site_id, group_id)
      url = build_url ['sites', site_id, 'groups', group_id, 'users']
      (get url).users.user.to_a.map { |user| User.new(user) }
    end

    def add_user_to_site(site_id, user)
      url = build_url ['sites', site_id, 'users']
      User.new((post url, { :user => user }).user)
    end

    def add_user_to_group(site_id, group_id, user_id)
      url = build_url ['sites', site_id, 'groups', group_id, 'users']
      User.new((post url, { :user => { :id => user_id } }).user)
    end

    def create_group(site_id, group)
      url = build_url ['sites', site_id, 'groups']
      Group.new((post url, { :group => { :name => group } }).group)
    end

    def delete_group(site_id, group_id)
      url = build_url ['sites', site_id, 'groups', group_id]
      delete url
    end

    def remove_user_from_group(site_id, group_id, user_id)
      url = build_url ['sites', site_id, 'groups', group_id, 'users', user_id]
      delete url
    end

    def remove_user_from_site(site_id, user_id)
      url = build_url ['sites', site_id, 'users', user_id]
      delete url
    end

    def update_user(site_id, user)
      url = build_url ['sites', site_id, 'users', user[:id]]
      User.new((put url, { :user => user }).user)
    end

    def update_group(site_id, group)
      url = build_url ['sites', site_id, 'groups', group[:id]]
      Group.new((put url, { :group => group }).group)
    end
  end
end
