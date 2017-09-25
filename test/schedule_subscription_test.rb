require 'test_helper'

class TableauRestApiTest < Minitest::Test
  def test_can_query_schedules
    VCR.use_cassette("schedules") do
      schedules = TableauRestApi::Resource.new.schedules
      assert schedules.is_a? Array
      assert_equal schedules.first.name, 'Weekday mornings'
    end
  end
   
  def test_can_query_subscriptions
    VCR.use_cassette("subscriptions") do
      req = TableauRestApi::Resource.new
      assert site = req.sites.first
      assert req.subscriptions(site.id).is_a? Array
    end
  end
  
  def test_can_delete_subscription
    VCR.use_cassette("delete_subscription") do
      req = TableauRestApi::Resource.new
      assert site_id = req.sites.first.id
      assert subscription = req.subscriptions(site_id).first
      assert_nil req.delete_subscription(site_id, subscription.id)
    end
  end
  
  def test_can_delete_schedule
    VCR.use_cassette("delete_schedule") do
      req = TableauRestApi::Resource.new
      assert site_id = req.sites.first.id
      assert schedule = req.schedules.first
      assert_nil req.delete_schedule(schedule.id)
    end
  end
end
