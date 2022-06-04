
require_relative "./isbn"


describe ISBN do
  describe "ensure_correctness_input," do
    context "when passing a non string/number as paramer," do
      it "should raise argument error" do
        expect {ISBN.ensure_correctness_input true}.to raise_error ArgumentError
        expect {ISBN.ensure_correctness_input false}.to raise_error ArgumentError
        expect {ISBN.ensure_correctness_input nil}.to raise_error ArgumentError
      end
    end

    context "when passing an invalid string," do
      it "should raise argument error if length is different than 12 and 13" do
        expect {ISBN.ensure_correctness_input "97821234568"}.to raise_error ArgumentError
        expect {ISBN.ensure_correctness_input "97821234568034"}.to raise_error ArgumentError
      end

      it "should raise argument error if any non numeric digit is found" do
        expect {ISBN.ensure_correctness_input "97821234568O3"}.to raise_error ArgumentError
        expect {ISBN.ensure_correctness_input "9782123A5680"}.to raise_error ArgumentError
      end
    end

    context "when passing a valid string," do
      it "should not raise errors" do
        expect {ISBN.ensure_correctness_input "9782123456803"}.not_to raise_error
        expect {ISBN.ensure_correctness_input "012345678901"}.not_to raise_error
      end
    end
  end

  describe "get_check_digit," do
    it "should return '3' when passing '978212345680'" do
      expect(ISBN.get_check_digit "978212345680").to eq "3"
    end

    it "should return 4 when passing '978014300723'" do
      expect(ISBN.get_check_digit "978014300723", true).to eq 4
    end

    it "should return '7' when passing 748174308791" do
      expect(ISBN.get_check_digit 748174308791).to eq "7"
    end
  end

  describe "is_valid?," do
    it "should return true when passing 7481743087917" do
      expect(ISBN.is_valid? 7481743087917).to be true
    end

    it "should return false when passing 7481743087918" do
      expect(ISBN.is_valid? 7481743087918).to be false
    end

    it "should return false when passing '012345678901'" do
      expect(ISBN.is_valid? '012345678901').to be false
    end

    it "should return true when passing '9780143007234'" do
      expect(ISBN.is_valid? '9780143007234').to be true
    end
  end
end
