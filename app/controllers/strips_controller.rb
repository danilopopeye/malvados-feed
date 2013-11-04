class StripsController < ApplicationController
  def show
    @settings = StripBuilder.new.settings
    @latest = Strip.latest
    @isLatest = params[:latest]
    @strips = if params[:latest]
      [ @latest ]
    else
      Strip.order_by(:number => :desc)
    end
  end
end
