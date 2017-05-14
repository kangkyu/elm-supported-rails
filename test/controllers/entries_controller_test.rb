require 'test_helper'

class EntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get entries_url, as: :json
    assert_response :success
  end

  test "should get random entries" do
    get random_entries_url, as: :json
    assert_response :success
  end
end
