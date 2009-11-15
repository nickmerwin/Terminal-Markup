$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

=begin rdoc
TerminalMarkup
  by Nick Merwin
  
Usage:
  "string".in_red.as_underline
  
  obj = Object.new
  obj.in_blue
  
Extra:

  To see examples of all markup:
    $ terminal_markup
  
=end

module TerminalMarkup
  VERSION = "0.0.3"
  DATE    = "11.15.09"
  CREDITS = "TerminalMarkup v.#{VERSION}\n  by Nick Merwin (http://lemurheavy.com) #{DATE}"

  FORMATTING = {
    :bright     => 1,
    :dim        => 2,
    :underline  => 4,
    :blink      => 5,
    :reverse    => 7,
    :hidden     => 8
  }

  COLOR = {
    :black    => 30, 
    :red      => 31,
    :green    => 32,
    :yellow   => 33,
    :blue     => 34,
    :magenta  => 35,
    :cyan     => 36,
    :white    => 37
  }

  BACKGROUND_COLOR = {
    :black    => 40,
    :red      => 41,
    :green    => 42,
    :yellow   => 43,
    :blue     => 44,
    :magenta  => 45,
    :cyan     => 46,
    :white    => 47
  }

  PREPOSITION_MAP = {
    FORMATTING        => "as",
    COLOR             => "in",
    BACKGROUND_COLOR  => "on"
  }

  module InstanceMethods
    TerminalMarkup::PREPOSITION_MAP.each do |markup, preposition|
      markup.each do |name, code|
        define_method "#{preposition}_#{name}" do
          with_escape_code code
        end
      end
    end

    # returns the string wrapped in the supplied escape code
    def with_escape_code(code)
      "\\e[#{code}m#{self.to_s}\\e[0m"
    end

    # for printing to console with escape codes intact
    def escape
      eval '"'+ to_s.gsub(/\"/,'\"') + '"'
    end
    
  end
end

class String
  include TerminalMarkup::InstanceMethods
end

class Object
  include TerminalMarkup::InstanceMethods
end