require "isbn/isbn"

class IsbnApiController < ActionController::API
  def check_validity
    response = {}

    begin
      is_valid = ISBN.is_valid? params[:isbn]

      response[:result] = is_valid ? "Valid" : "Not Valid"

      status_code = 200
    rescue ArgumentError => err
      status_code = 400
      response[:error_message] = err.message
    end

    render json: response, status: status_code
  end

  def get_check_digit
    response = {}

    begin
      check_digit = ISBN.get_check_digit params[:isbn]

      response[:result] = "Check Digit: #{check_digit}"

      status_code = 200
    rescue ArgumentError => err
      status_code = 400
      response[:error_message] = err.message
    end

    render json: response, status: status_code
  end
end
