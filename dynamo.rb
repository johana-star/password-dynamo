require 'rubygems'
require 'sinatra'

get '/' do
  words, password                                   = [], ''
  min_word_length, max_word_length, words_in_password = 4, 8, 4 + rand(2)

  File.open("words.txt") do |file|
    file.each do |line| 
      if line.length <= max_word_length and line.length >= min_word_length
        words << line.strip.downcase
      end
    end
  end

  def spacer
    array = Array(0..9) + ['!', '~', '-', '_', ' ', '+', '=', '%', '$', '#', '@']
    array.shuffle.first.to_s
  end

  words_in_password.times do
    password += words.shuffle.first + spacer
  end

  password.chop!

  "#{password}"
end