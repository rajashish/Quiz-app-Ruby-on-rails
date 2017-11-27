require 'test_helper'

class QuizplayControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get quizplay_index_url
    assert_response :success
  end

end
