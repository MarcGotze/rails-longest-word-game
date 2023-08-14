require 'uri'
require 'net/http'

class GamesController < ApplicationController
  def new
    @letters = Array('A'..'Z')
  end

  def score
    @grid = params[:letters]
    @answer = params[:answer].upcase.split('')
    @bool = false

    uri = URI("https://wagon-dictionary.herokuapp.com/#{params[:answer]}")
    res = Net::HTTP.get_response(uri)
    @response = JSON.parse(res.body)

    @answer.each do |letter|
      if @grid.include? letter
        if @response["found"]== true
          @bool = true
        else
          @bool = false
        end
      else
        @bool = false
        break
      end
    end
  end
end
