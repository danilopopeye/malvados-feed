require 'open-uri'
require 'nokogiri'
require 'yaml'

class Scrapper
  attr_reader :settings

  def initialize
    @settings = YAML.load_file Rails.root.join 'config/application.yml'
    @settings.merge! @settings.fetch(Rails.env, {})
    @settings.symbolize_keys!
  end

  def scrap number
    print "Started #{number}: "

    if exists? number
      print "SKIPPED\n"
    else
      if get_and_parse(number)
        puts "DONE"
      else
        puts "FAIL"
      end
    end
  end

  def latest
    strip = get_latest
    scrap strip
  end

  def all
    strip_number = get_latest

    while strip_number > 0 do
      scrap strip_number
      strip_number = get_previous strip_number
    end
  end

  def url
    @settings[:base_url]
  end

  def get_previous number
    Strip.find_by(number: number)[:previous]
  end

  def get_latest
    doc = Nokogiri::HTML open self.url
    link = doc.css('frame[name="mainFrame"]').first
    get_number link.attr('src') if link
  end

  def exists? number
    Strip.where(number: number).exists?
  end

  def get_number strip
    strip.match(/index([0-9]+)/)[1].to_i
  end

  def build_strip_url number
    "#{self.url}index#{number}." + (number == 123 ? 'htm' : 'html')
  end

  def build_strip_image url
    if url[0..3] == 'http'
      url
    else
      self.url + url
    end
  end

  def get_and_parse number
    strip = Strip.new number: number

    open build_strip_url(number) do |req|
      strip[:updated_at] = req.last_modified
      @doc = Nokogiri::HTML(req)
    end

    strip[:image] = build_strip_image @doc.css('img[src^="tir"]').attr('src')

    header = @doc.css('img[src^="logo"]')

    unless header.empty?
      strip[:header] = build_strip_image header.attr('src')
    end

    if number > 1
      strip[:previous] = get_number @doc.css('a[href*=index]').last.attr('href').to_s
    else
      strip[:previous] = 0
    end

    strip.save
  end
end
