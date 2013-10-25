class StripsController < ApplicationController
  def show
    @settings = Scrapper.new.settings
    @latest = Strip.latest
    @isLatest = params[:latest]
    @strips = if params[:latest]
      [ @latest ]
    else
      Strip.all
    end
  end
end
