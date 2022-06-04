require "test_helper"

class IsbnControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def test_index
    get '/'
    assert_equal 200, status
  end
end
