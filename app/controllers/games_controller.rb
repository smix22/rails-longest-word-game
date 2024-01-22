class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @grid = []
    10.times do
      @grid += ('A'..'Z').to_a.sample(1)
    end
    return @grid
  end

  def score
    @word = params[:word].upcase
    @grid = params[:grid].delete(" ")

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    attempt_serialized = URI.open(url).read
    result = JSON.parse(attempt_serialized)
    match = @word.chars.all? { |letter| @word.count(letter) <= @grid.count(letter) }

    if result["found"]
      if match
        @answer = "Congratulations! #{@word} is a valid English word."
      else
        @answer = "Sorry, but your word does not match the grid."
      end
    else
      @answer = "Sorry, but #{@word} is not an English word."
    end
  end
end
