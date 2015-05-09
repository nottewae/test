class HomeController < ApplicationController
  def index
    @arrdd="sdfgh"
    puts @arrdd
  end
  def carousel
    render layout: 'jquery'
  end
end
