require 'JSON'
require 'open-uri'

class GamesController < ApplicationController
	def new
		@letters = ('A' .. 'Z').to_a.sample(8)
	end

	def score
		word_array = params[:word].upcase.split("").sort
		letters_array = params[:letters].split.sort
		# raise
		url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
		dictionary = JSON.parse(open(url).read)

		if letters_array & word_array != word_array
			@result = "#{params[:word]} does not contain valid letters. Please choose from #{params[:letters]}"
		elsif (letters_array & word_array == word_array) && (dictionary["found"] != true)
			@result = "Invalid word."
		elsif (letters_array & word_array == word_array) && dictionary["found"]
			@result = "Valid word! Your score is #{dictionary["length"]}!"
		end
	end

end
