require 'open-uri'
require 'nokogiri'
require 'yaml'

class StripBuilder
  attr_reader :settings # used in Stripscontroller

  def initialize
    @settings = YAML.load_file Rails.root.join 'config/application.yml'
    @settings.merge! @settings.fetch(Rails.env, {})
    @settings.symbolize_keys!
  end

  def build number
    get_and_parse number
  end

  def latest
    doc = Nokogiri::HTML open(base_url)
    link = doc.css('frame[name="mainFrame"]').first
    parse_number link.attr('src') if link
  end

  def exists? number
    Strip.where(number: number).exists?
  end

  def previous number
    Strip.find_by(number: number)[:previous]
  end

  private

  def base_url
    @settings[:base_url]
  end

  def parse_number strip
    strip.match(/index([0-9]+)/)[1].to_i
  end

  def parse_url url
    if url[0..3] == 'http'
      url
    else
      base_url + url
    end
  end

  def strip_url number
    "#{base_url}index#{number}." + (number == 123 ? 'htm' : 'html')
  end

  def parse_previous doc, number
    if number > 1
      parse_number doc.css('a[href*=index]').last.attr('href').to_s
    else
      0
    end
  end

  def parse_strip_image doc
    parse_url doc.css('img[src^="tir"]').attr('src')
  end

  def parse_strip_header doc
    header = doc.css('img[src^="logo"]')

    unless header.empty?
      parse_url header.attr('src')
    end
  end

  def get_and_parse number
    strip = Strip.new number: number

    open strip_url(number) do |req|
      doc = Nokogiri::HTML(req)

      strip[:updated_at] = req.last_modified
      strip[:image] = parse_strip_image doc
      strip[:header] = parse_strip_header doc
      strip[:previous] = parse_previous doc, number
    end

    strip
  end
end
