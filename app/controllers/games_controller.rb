require 'open-uri'
require 'json'

class GamesController < ApplicationController

  
  def new
    @letters = 7.times.map { ('A'..'Z').to_a.sample } + 3.times.map { ['E','O', 'U', 'A', 'I'].sample }
  end

  def score
    @letters = params[:letters].split
    @answer = (params[:answer] || "").upcase
    @included = included?(@answer, @letters)
    @english_word = english_word?(@answer)
  end

  def english_word?(answer)
    response = open("https://wagon-dictionary.herokuapp.com/#{answer}")
    json = JSON.parse(response.read)
    json['found']
  end

  def included?(answer, letters)
    answer.chars.all? { |letter| answer.count(letter) <= letters.count(letter) }
  end
  
end
