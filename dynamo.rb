require 'sinatra'

def load_dictionary(dictionary = "words.txt", max_word_length = 10)
  words = []
  
  File.open(dictionary) do |file|
    file.each do |line| 
      words << line.strip.downcase unless line.length > max_word_length
    end
  end
  
  return words
end

SPACERS = Array(0..9).collect {|i| i.to_s} + ['!', '~', '-', '_', ' ', '+', '=', '%', '$', '#', '@']
WORDS   = load_dictionary

def generate_password
  password          = ''
  words_in_password = 3 + rand(2)

  (words_in_password - 1).times do
    password += WORDS.choice + SPACERS.choice
  end

  password += WORDS.choice
end
# FIXME Everything above this line can probably be stored in a class.

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @password = generate_password

  erb :index
end

get '/*' do
  redirect to('/')
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