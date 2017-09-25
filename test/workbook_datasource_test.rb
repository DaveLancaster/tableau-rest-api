require 'test_helper'

class TableauRestApiTest < Minitest::Test
  def test_can_query_workbooks
    VCR.use_cassette("query_workbooks") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first.id
      assert_equal req.query_workbooks(site).first.name, 'Superstore'
    end
  end
  
  def test_can_get_workbook
    VCR.use_cassette("get_workbook") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first.id
      assert wb = req.query_workbooks(site).first.id
      assert req.get_workbook(site, wb).body.is_a? String
    end 
  end
  
  def test_can_get_datasource
    VCR.use_cassette("get_datasource") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first.id
      assert ds = req.datasources(site).first.id
      assert req.get_datasource(site, ds).body.is_a? String
    end 
  end

  def test_can_delete_workbook
    VCR.use_cassette("delete_workbook") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert book = site.workbooks.last
      assert_nil req.delete_workbook(site.id, book.id)
    end
  end
  
  def test_can_delete_datasource
    VCR.use_cassette("delete_datasource") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert source = site.datasources.last
      assert_nil req.delete_datasource(site.id, source.id)
    end
  end
end
