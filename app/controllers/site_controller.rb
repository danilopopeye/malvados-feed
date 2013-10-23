class SiteController < ApplicationController
  def index
    @title = 'Malvados Feed - Tirinhas dos Malvados'
    @latest = Strip.latest
    @count = Strip.count
  end
end
