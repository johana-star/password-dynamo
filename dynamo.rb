require 'sinatra'

SPACERS = Array(0..9).collect {|i| i.to_s} + ['!', '~', '-', '_', ' ', '+', '=', '%', '$', '#', '@']

def spacer
  SPACERS.choice
end

def generate_password
  words              = []
  password           = ''
  min_word_length    = 4
  max_word_length    = 8
  words_in_password  = 4 + rand(2)

  File.open("words.txt") do |file| # FIXME figure out how to load this once.
    file.each do |line| 
      if line.length <= max_word_length and line.length >= min_word_length
        words << line.strip.downcase
      end
    end
  end

  words_in_password.times do
    password += words.shuffle.first + spacer
  end

  password.chop
end

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @password = generate_password

  erb :index
end

__END__

@@ layout
<html>
  <head>
    <title><%= @title %></title>
    <style>
      body { margin: 40px; font: 40px/48px helvetica;}
    </style>
  </head>
  <body>
    <%= yield %>
  </body>
</html>

@@ index
<p><%= @password %></p>