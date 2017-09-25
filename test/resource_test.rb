require 'test_helper'

class TableauRestApiTest < Minitest::Test
  def test_sites_response_iterable
    VCR.use_cassette("sites") do
      sites = TableauRestApi::Resource.new.sites
      assert sites.is_a? Array
    end
  end

  def test_can_switch_site
    VCR.use_cassette("switch_site") do
      req = TableauRestApi::Resource.new
      assert token = req.switch_site({ 'site' => { 'contentUrl' => 'test_si' }})
      assert token.is_a? TableauRestApi::Token
    end
  end

  def test_can_delete_site
    VCR.use_cassette("delete_site") do
      req = TableauRestApi::Resource.new
      assert token = req.switch_site({ 'site' => { 'contentUrl' => 'testsite6' }})
      assert site = req.sites.last
      assert_nil req.delete_site(site.id)
    end
  end

  def test_can_query_server_info
    VCR.use_cassette("server_info") do
      req = TableauRestApi::Resource.new
      assert info = req.server_info
      assert info.is_a? TableauRestApi::Server
      assert_equal info.api_version, req.config[:api_version]
    end
  end
  
  def test_sites_returns_a_site
    VCR.use_cassette("sites") do
      site = TableauRestApi::Resource.new.sites.first
      assert_equal site.id, '1a10f5b9-029b-43e4-a620-773d1690338c'
      assert_equal site.name, 'Default'
    end
  end
  
  def test_users_on_site_returns_a_user
    VCR.use_cassette("users_on_site") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first.id
      assert user = req.users_on_site(site).first
      assert_equal user.name, 'assembly'
    end
  end
  
  def test_groups_returns_a_group
    VCR.use_cassette("groups") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first.id
      assert group = req.groups(site).first
      assert_equal group.name, 'A Group For Testing'
    end
  end
 
  def test_datasources_returns_a_datasource
    VCR.use_cassette("datasources") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first.id
      assert ds = req.datasources(site).first
      assert_equal ds.type, 'redshift'
    end
  end

  def test_users_in_group_returns_a_user
    VCR.use_cassette("users_in_group") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first.id
      assert group = req.groups(site).first.id
      assert_equal req.users_in_group(site, group).first.name, 'assembly'
    end
  end
  
  def test_can_add_user_to_site
    VCR.use_cassette("add_user") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first.id
      assert user = req.add_user_to_site(site, { :name => 'TestUser', :siteRole => 'Viewer' })
      assert_equal user.name, 'TestUser'
    end
  end

  def test_can_create_group
    VCR.use_cassette("create_group") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert group = req.create_group(site.id, 'A Group For Testing')
      assert_equal group.name, 'A Group For Testing'
    end
  end
  
  def test_can_add_user_to_group
    VCR.use_cassette("add_user_to_group") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert group = site.groups.last
      assert req.add_user_to_group(site.id, group.id, site.users.last.id)
    end
  end
  
  def test_can_delete_group
    VCR.use_cassette("delete_group") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert_nil req.delete_group(site.id, site.groups.find { |gp| gp.name == 'A Group For Testing' }.id)
    end
  end
end
