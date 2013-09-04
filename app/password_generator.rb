class PasswordGenerator
  attr_accessor :dictionary_path, :max_word_length, :words_in_password

  def initialize(args = {})
    @dictionary_path   = args[:dictionary_path]
    @max_word_length   = args[:max_word_length]
    @words_in_password = args[:words_in_password]
  end

  def generate_password
    clean_dictionary.shuffle.first(@words_in_password).join(" ")
  end

  def count_words
    dictionary.count
  end

  def clean_dictionary
    dictionary.map { |line| line.strip.downcase }
  end

  def dictionary
    File.open(@dictionary_path) do |file|
      file.select { |line| line.length <= max_word_length }
    end
  end
end