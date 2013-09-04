module PasswordGenerator
  def load_dictionary(dictionary = "words.txt", max_word_length = 10)
    File.open(dictionary) do |file|
      file.select { |line| line.length <= max_word_length }
          .map    { |line| line.strip.downcase }
    end
  end

  def generate_password(password_length_in_words = 4)
    load_dictionary.shuffle.first(password_length_in_words).join(" ")
  end

  def count_words(dictionary = "words.txt", max_word_length = 10)
    File.open(dictionary) do |file|
      file.select { |line| line.length <= max_word_length }.count
    end
  end
end