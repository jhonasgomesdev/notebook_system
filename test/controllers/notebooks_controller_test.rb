require "test_helper"

class NotebooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notebooks_index_url
    assert_response :success
  end

  test "should get show" do
    get notebooks_show_url
    assert_response :success
  end
end
