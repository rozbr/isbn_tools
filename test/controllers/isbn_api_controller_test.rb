require "test_helper"

class IsbnApiControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def test_valid_isbn_numbers
    get '/api/check_validity/9780143007234'
    assert_equal 200, status
    assert_equal({ "result" => "Valid" }, response.parsed_body)

    get '/api/check_validity/7481743087917'
    assert_equal 200, status
    assert_equal({ "result" => "Valid" }, response.parsed_body)
  end

  def test_non_valid_isbn_numbers
    get '/api/check_validity/7481743087913'
    assert_equal 200, status
    assert_equal({ "result" => "Not Valid" }, response.parsed_body)

    get '/api/check_validity/7481743087918'
    assert_equal 200, status
    assert_equal({ "result" => "Not Valid" }, response.parsed_body)
  end

  def test_check_digit
    get '/api/get_check_digit/978212345680'
    assert_equal 200, status
    assert_equal({ "result" => "Check Digit: 3" }, response.parsed_body)

    get '/api/get_check_digit/748174308791'
    assert_equal 200, status
    assert_equal({ "result" => "Check Digit: 7" }, response.parsed_body)
  end

  def test_invalid_length_string
    get '/api/get_check_digit/9782123456'
    assert_equal 400, status
    assert_equal({ "error_message" => "Expected a string with 12 or 13 digits but 10 digits were given" }, response.parsed_body)

    get '/api/check_validity/74817430879141'
    assert_equal 400, status
    assert_equal({ "error_message" => "Expected a string with 12 or 13 digits but 14 digits were given" }, response.parsed_body)
  end

  def test_invalid_format_string
    get '/api/get_check_digit/123456789O123'
    assert_equal 400, status
    assert_equal({ "error_message" => "Expected a numeric string but a non numeric digit, O, was found in the index position 9" }, response.parsed_body)

    get '/api/check_validity/0685A68745945'
    assert_equal 400, status
    assert_equal({ "error_message" => "Expected a numeric string but a non numeric digit, A, was found in the index position 4" }, response.parsed_body)
  end
end
