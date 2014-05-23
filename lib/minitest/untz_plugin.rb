require 'minitest'

module Minitest
  def self.plugin_untz_options(opts, options) # :nodoc:
    opts.on "-u", "--untz", "Run your tests with a beat you can dance to." do
      UntzIO.untz!
    end
  end

  def self.plugin_untz_init(options) # :nodoc:
    if UntzIO.untz?
      klass = ENV['TERM'] =~ /^xterm|-256color$/ ? UntzLOL : UntzIO
      io = klass.new options[:io]

      self.reporter.reporters.grep(Minitest::Reporter).each do |rep|
        rep.io = io
      end
    end
  end

  class UntzIO

    def self.untz!
      @untz = true
    end

    def self.untz?
      @untz ||= false
    end

    # Start an escape sequence
    ESC = "\e["

    # End the escape sequence
    NND = "#{ESC}0m"

    attr_reader :io

    def initialize(io) # :nodoc:
      @io = io
      # stolen from minitest/pride, which in turn was
      # stolen from /System/Library/Perl/5.10.0/Term/ANSIColor.pm
      # also reference http://en.wikipedia.org/wiki/ANSI_escape_code
      @colors ||= (31..36).to_a
      @size   = @colors.size
      @index  = 0
    end

    def print(o)
      case o
      when '.', 'S'
        io.print "#{untz(o)} "
      when 'E'
        io.print "#{ESC}41m#{ESC}37m#{o}#{NND} "
      when 'F'
        io.print "#{ESC}41m#{ESC}37mSKREE#{NND} "
      else
        io.print "#{o} "
      end
    end

    def puts(*o) # :nodoc:
      o.map! { |s|
        s.to_s.sub(/Finished/) {
          @index = 0
          'Ravin\' run'.split(//).map { |c|
            untz(c)
          }.join
        }
      }

      io.puts(*o)
    end

    def untz(string)
      string = case string
               when '.' then 'untz'
               when 'S' then 'wub'
               else string
               end
      c = @colors[@index % @size]
      @index += 1
      "#{ESC}#{c}m#{string}#{NND}"
    end

    def method_missing(msg, *args) # :nodoc:
      io.send(msg, *args)
    end
  end

  class UntzLOL < UntzIO
    PI_3 = Math::PI / 3 # :nodoc:

    def initialize(io) # :nodoc:
      @colors = (0...(6 * 7)).map { |n|
        n *= 1.0 / 6
        r  = (3 * Math.sin(n           ) + 3).to_i
        g  = (3 * Math.sin(n + 2 * PI_3) + 3).to_i
        b  = (3 * Math.sin(n + 4 * PI_3) + 3).to_i

        36 * r + 6 * g + b + 16
      }

      super
    end

    def untz(string)
      string = case string
               when '.' then 'untz'
               when 'S' then 'wub'
               else string
               end
      c = @colors[@index % @size]
      @index += 1
      "#{ESC}38;5;#{c}m#{string}#{NND}"
    end
  end

end
