require 'helper'

class TestLitmosClient < Test::Unit::TestCase
  
  VALID_API_KEY = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
  INVALID_API_KEY = 'not_a_valid_api_key'
  
  should "not raise an error if the API key is valid" do
    assert_nothing_raised do
      LitmosClient::API.new(VALID_API_KEY)
    end
  end
  
  should "raise an error if the API key is not provided" do
    assert_raise(ArgumentError) do
      LitmosClient::API.new()
    end
  end
  
  should "raise an error if the API key is malformed" do
    assert_raise(ArgumentError) do
      LitmosClient::API.new(INVALID_API_KEY)
    end
  end
  
  # TODO: Implement tests!
end
