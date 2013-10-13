class SiteController < ApplicationController
  def index
    @latest = Strip.find_by number: latest
    @count = Strip.count
  end

  private

  def latest
    Strip.max(:number) || 0
  end
end
