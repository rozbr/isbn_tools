
module ISBN
  def self.check_value_digits value
    non_numeric_index = value =~ /[^0-9]/

    unless non_numeric_index.class == NilClass
      raise ArgumentError.new "Expected a numeric string but a non numeric digit, #{value[non_numeric_index]}, was found in the index position #{non_numeric_index}"
    end
  end

  def self.check_value_length value
    unless [12, 13].include? value.size
      raise ArgumentError.new "Expected a string with 12 or 13 digits but #{value.size} digits were given"
    end
  end

  def self.check_value_type value
    unless [Integer, String].include? value.class
      raise ArgumentError.new "Expected a String/Number but #{value.class} was given"
    end
  end

  def self.ensure_correctness_input value
    ISBN.check_value_type value

    value = value.to_s

    ISBN.check_value_length value

    ISBN.check_value_digits value

    value
  end

  def self.get_check_digit value, return_as_number=false
    sum = 0
    value = ISBN.ensure_correctness_input value

    12.times do |index|
      sum += value[index].to_i * (index.odd? ? 3 : 1)
    end

    check_digit = 10 - sum % 10
    check_digit = check_digit % 10

    return_as_number ? check_digit : check_digit.to_s
  end

  def self.is_valid? value
    value = ISBN.ensure_correctness_input value
    check_digit = ISBN.get_check_digit value

    value[12] == check_digit
  end
end
