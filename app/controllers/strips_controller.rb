class StripsController < ApplicationController
  def show
    @settings = StripBuilder.new.settings
    @latest = Strip.latest

    @strips = if params.has_key?(:latest)
      [ @latest ]
    else
      Strip.order_by(number: :desc)
    end
  end
end
