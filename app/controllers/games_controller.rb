require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = ""
    @score = 0
    words = params[:grid]
    grid = params[:word]

    response = open("https://wagon-dictionary.herokuapp.com/#{words}")
    json = JSON.parse(response.read)
    result = json['found']

    words.chars.each do |letter|
      grid.include?(letter)
      @score += 1
    end

    if !words.chars.all? { |letter| grid.include?(letter) }
      @answer = "Sorry but #{words} cannot be built out of #{grid}"
    elsif result == false
      @answer = "Not an english word !"
    else
      @answer = "Well done ! Your score is #{@score}"
    end
  end
end
