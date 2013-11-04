class Scrapper
  attr_reader :builder

  def initialize
    @builder ||= StripBuilder.new
  end

  def latest
    scrap @builder.latest
  end

  def all
    strip_number = @builder.latest

    while strip_number > 0 do
      scrap strip_number
      strip_number = @builder.previous strip_number
    end
  end

  private

  def scrap number
    print "Started #{number}: "

    if @builder.exists? number
      print "SKIPPED\n"
    else
      strip = @builder.build(number)

      if strip.save
        puts "DONE"
      else
        puts "FAIL"
      end
    end
  end
end
