class StripsController < ApplicationController
  def show
    @settings = Scrapper.new.settings
    @strips = Strip.all
    @latest = Strip.latest

    respond_to do |format|
      format.atom
      format.any { redirect_to strips_path(format: :atom) }
    end
  end
end
