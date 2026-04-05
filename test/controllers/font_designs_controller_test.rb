require "test_helper"

class FontDesignsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get font_designs_index_url
    assert_response :success
  end
end