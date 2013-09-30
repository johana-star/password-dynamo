class PasswordGenerator
  attr_accessor :dictionary_path, :words_in_password

  def initialize(args = {})
    @dictionary_path   = args[:dictionary_path]
    @words_in_password = args[:words_in_password]
  end

  def generate_password
    clean_dictionary.shuffle.first(words_in_password).join(" ")
  end

  def count_words
    dictionary.count
  end

  def clean_dictionary
    dictionary.map { |line| line.strip.downcase }
  end

  def dictionary
    File.new dictionary_path
  end
end