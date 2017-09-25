require 'test_helper'

class TableauRestApiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::TableauRestApi::VERSION
  end

  def test_can_initialise_a_client
    assert TableauRestApi::Client.new
  end

  def test_can_read_client_properties
    config = TableauRestApi::Client.new.config
    assert_equal config[:host], 'https://tableau.lvh.me'
    assert_equal config[:api_version], '2.6'
    assert_equal config[:base], 'api'
  end

  def test_can_signin
    VCR.use_cassette("signin") do
      client = TableauRestApi::Client.new
      assert resp = client.login
      assert resp, 'KphxwyjVTdSMSM3-ODzcOA|zoYhQEflzIWtA8qXFdj886L4TCgjH7WG'
    end
  end
  
  def test_token_is_nil_before_auth
    VCR.use_cassette("signin") do
      client = TableauRestApi::Client.new
      assert_nil client.token
    end
  end
  
  def test_token_has_value_after_auth
    VCR.use_cassette("signin") do
      client = TableauRestApi::Client.new
      assert client.login
      assert_equal client.token.value, "KphxwyjVTdSMSM3-ODzcOA|zoYhQEflzIWtA8qXFdj886L4TCgjH7WG"
    end
  end
  
  def test_authorised_returns_false_before_signin
    client = TableauRestApi::Client.new
    assert_equal client.authorised?, false
  end
  
  def test_authorised_returns_true_after_signin
    VCR.use_cassette("signin") do
      client = TableauRestApi::Client.new
      assert client.login
      assert_equal client.authorised?, true
    end
  end
  
  def test_can_logout
    VCR.use_cassette("signout") do
      client = TableauRestApi::Client.new
      assert client.login
      assert client.logout
      assert_equal client.authorised?, false
    end
  end
end
