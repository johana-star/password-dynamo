require 'sinatra'

def spacer
  array = Array(0..9) + ['!', '~', '-', '_', ' ', '+', '=', '%', '$', '#', '@']
  array.shuffle.first.to_s
end

def generate_password
  words              = []
  password           = ''
  max_word_length    = 10
  words_in_password  = 3 + rand(2)

  File.open("words.txt") do |file| # FIXME figure out how to load this once.
    file.each do |line| 
      words << line.strip.downcase unless line.length > max_word_length
    end
  end

  words_in_password.times do
    password += words.shuffle.first + spacer
  end

  password.chop!
  
  return password
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