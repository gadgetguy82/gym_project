require("minitest/autorun")
require("minitest/rg")
require_relative("../member")

class MemberTest < Minitest::Test

  def setup
    @member = Member.new(
      {
        "first_name" => "Joe",
        "last_name" => "Smith",
        "date_of_birth" => "23/04/1990",
        "street" => "23 Springvalley Terrace",
        "city" => "Edinburgh",
        "postcode" => "EH10 4PY",
        "phone" => "0131 223 4455"
      }
    )
    @member.save
  end

  def test_get_first_name
    assert_equal("Joe", @member.first_name)
  end

  def test_get_last_name
    assert_equal("Smith", @member.last_name)
  end

  def test_get_date_of_birth
    assert_equal("23/04/1990", @member.date_of_birth)
  end

  def test_get_street
    assert_equal("23 Springvalley Terrace", @member.street)
  end

  def test_get_city
    assert_equal("Edinburgh", @member.city)
  end

  def test_get_postcode
    assert_equal("EH10 4PY", @member.postcode)
  end

  def test_get_phone
    assert_equal("0131 223 4455", @member.phone)
  end

end
