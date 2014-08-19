class Scrapper
  attr_reader :builder

  def initialize
    @builder ||= StripBuilder.new
  end

  def latest
    number = @builder.latest

    if scrap(number)
      Rails.cache.write('strip#latest', number)
    end
  end

  def all
    strip_number = @builder.latest

    while strip_number > 0 do
      scrap(strip_number)
      strip_number = @builder.previous(strip_number)
    end
  end

  private

  def scrap(number)
    print "Started #{number}: "
    saved = true

    if @builder.exists?(number)
      puts 'SKIPPED'
    else
      strip = @builder.build(number)
      saved = strip.save

      if saved
        puts 'DONE'
      else
        puts 'FAIL'
      end
    end

    saved
  end
end
