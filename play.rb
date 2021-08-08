# Hangman game from youtube.com/watch?v=uBwGfseeRL4
class Hangman

  def initialize
    #@letters = ('a'..'z').to_a
    @words = words.sample  #randomly pick one of the array items
    @attempts = 7
    @word_teaser = ""
    @previous_guesses = []

    @words.first.size.times do
      @word_teaser += "_ "
    end
  end

  def words
    [
      ["cricket", "A musical bug"],
      ["house", "A place to sleep"],
      ["celebrate", "Remembering special moments"],
      ["jogging", "We are not walking..."],
      ["cookies", "A monsters favorite food"],
      ["toothhurty", "A Dentists favorite time of the day"]
    ]
  end

  def begin
    #Prompt user for a letter
    puts "New Game started...To exit the game at any time type 'exit'"
    puts "Your word is #{@words.first.size} letters long."
    puts @word_teaser

    puts "Clue: #{ @words.last }"
    make_guess
  end

  def make_guess
    if @attempts > 0
      puts "Enter a letter"
      guess = gets.chomp.downcase

      case
      when guess == "exit"
        puts "Thank-you for playing!"
      when (@previous_guesses.include? guess)
          puts "You have already guess that letter."
          puts "Guesses: #{@previous_guesses.inspect}"
          make_guess
      when (@words.first.include? guess)
        update_teaser(guess) unless guess.nil?
        if @words.first == @word_teaser.split.join
          puts "Way to go! You guessed the word!"
        else
          puts "Good Guess!"
          add_to_previous_guesses guess
          puts @word_teaser
          make_guess
        end
      else
        @attempts -= 1
        if @attempts == 0
          puts "Incorrect Guess! Sorry you have no more attempts. Game Over!"
        else
          puts "Incorrect Guess! You have #{ @attempts } lives left. Try Again!"
          add_to_previous_guesses guess
          make_guess
       end
      end
    else
      puts "Game Over!"
    end
  end

  def add_to_previous_guesses last_guess
    @previous_guesses << last_guess
  end
  
  # replace blank values with letter if they match a letter in the word we are guessing
  def update_teaser last_guess
      new_teaser = @word_teaser.split
      new_teaser.each_with_index do |letter, index|
        if letter == "_" && @words.first[index] == last_guess
          new_teaser[index] = last_guess
        end
      end
      @word_teaser = new_teaser.join(' ')
  end

end

game = Hangman.new
game.begin