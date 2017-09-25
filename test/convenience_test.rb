require 'test_helper'

# Tests for convenience methods
class TableauRestApiTest < Minitest::Test
  def test_can_access_users_through_site
    VCR.use_cassette("users_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert users = site.users
      assert_equal users.first.name, 'assembly'
    end
  end
  
  def test_can_access_groups_through_site
    VCR.use_cassette("groups_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert groups = site.groups
      assert_equal groups.first.name, 'A Group For Testing'
    end
  end

  def test_can_access_projects_through_site
    VCR.use_cassette("projects_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert projects = site.projects
      assert_equal projects.first.name, 'Default'
    end
  end
  
  def test_can_access_datasources_through_site
    VCR.use_cassette("datasources_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert ds = site.datasources
      assert_equal ds.first.type, 'redshift'
    end
  end

  def test_can_access_workbooks_through_site
    VCR.use_cassette("workbooks_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert workbooks = site.workbooks
      assert_equal workbooks.first.name, 'Superstore'
    end
  end

  def test_can_create_group_through_site
    VCR.use_cassette("create_group_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert_equal site.create_group('A Testing Group').name, 'A Testing Group'
    end
  end

  def test_can_delete_group_through_site
    VCR.use_cassette("delete_group_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert_nil site.delete_group(site.groups.find { |gp| gp.name == 'A Testing Group' }.id)
    end
  end

  def test_can_add_user_to_group_through_site
    VCR.use_cassette("add_user_to_group_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert group = site.groups.last.id
      assert site.add_user_to_group(group, site.users.last.id)
    end
  end

  def test_can_remove_user_from_group_through_site
    VCR.use_cassette("remove_user_from_group_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert group = site.groups.last.id
      assert_nil site.remove_user_from_group(group, site.users[2].id)
    end
  end

  def test_can_remove_user_from_site_through_site
    VCR.use_cassette("remove_user_from_site_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert_nil site.remove_user_from_site(site.users.last.id)
    end
  end

  def test_can_update_user_through_site
    VCR.use_cassette("update_user_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert user = site.users.last
      assert_equal site.update_user({ :id => user.id, :siteRole => 'Viewer' }).site_role, 'Viewer'
    end
  end
  
  def test_can_update_group_through_site
    VCR.use_cassette("update_group_through_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert group = site.groups.last
      assert_equal site.update_group({ :id => group.id, :name => 'Renamed Group' }).name, 'Renamed Group'
    end
  end
end
