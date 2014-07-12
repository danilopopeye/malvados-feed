class StripsController < ApplicationController
  def show
    expires_in 1.hour, public: true

    @settings = StripBuilder.new.settings
    @latest = Strip.latest

    @strips = if params.has_key?(:latest)
      [ @latest ]
    else
      Strip.order_by(number: :desc)
    end
  end
end
