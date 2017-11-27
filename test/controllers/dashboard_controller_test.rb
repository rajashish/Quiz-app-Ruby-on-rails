require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get dash" do
    get dashboard_dash_url
    assert_response :success
  end

end
