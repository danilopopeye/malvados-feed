class SiteController < ApplicationController
  def index
    @latest = Strip.latest
    @count = Strip.count
  end
end
