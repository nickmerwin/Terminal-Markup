require File.dirname(__FILE__) + '/test_helper.rb'

class TestTerminalMarkup < Test::Unit::TestCase

  def setup
    @dummy = Dummy.new
  end

  def test_color
    assert_equal "\\e[31masdf\\e[0m", "asdf".in_red
    assert_equal "\\e[31masdf\\e[0m", @dummy.in_red
  end
  
  def test_formatting
    assert_equal "\\e[4masdf\\e[0m", "asdf".as_underline
    assert_equal "\\e[4masdf\\e[0m", @dummy.as_underline
  end
  
  def test_background_color
    assert_equal "\\e[41masdf\\e[0m", "asdf".on_red
    assert_equal "\\e[41masdf\\e[0m", @dummy.on_red
  end
  
  def test_escape
    assert_equal "asdf", "asdf".escape
    assert_equal "\e[31masdf\e[0m", "asdf".in_red.escape
    assert_equal "\e[31masdf\e[0m", @dummy.in_red.escape
  end
end
