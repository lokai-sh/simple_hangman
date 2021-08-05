# Hangman game from youtube.com/watch?v=uBwGfseeRL4
class Hangman

  def initialize
    @letters = ('a'..'z').to_a
    @words = words.sample
    @attempts = 7
    @word_teaser = ""
    @guesses = []

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
    print_teaser

    puts "Clue: #{ @words.last }"
    make_guess
  end

  def make_guess
    if @attempts > 0
      puts "Enter a letter"
      guess = gets.chomp.downcase

      #validate if the letter is part of the word
      good_guess = @words.first.include? guess

      if guess == "exit"
        puts "Thank-you for playing!"
      elsif @guesses.include? guess
          puts "You have already guess that letter."
          puts "Guesses: #{@guesses.inspect}"
          make_guess
      elsif good_guess
        puts "You are correct!"
        add_to_guesses guess
        print_teaser guess

        if @words.first == @word_teaser.split.join
          puts "Way to go! You guessed the word!"
        else
          make_guess
        end
      else
        puts "Bad Guess"
        add_to_guesses guess
        @attempts -= 1
        if @attempts == 0
          puts "Sorry you have no more attempts. Game Over!"
        else
          puts "Sorry... you have #{ @attempts } lives left. Try Again!"
          make_guess
        end
      end
    else
      puts "Game Over!"
    end
    
  end

  def add_to_guesses last_guess
    puts "Add to guesses"
    @guesses << last_guess
  end

  def print_teaser last_guess = nil
    update_teaser(last_guess) unless last_guess.nil?
    puts @word_teaser
  end

  def update_teaser last_guess
      new_teaser = @word_teaser.split
      new_teaser.each_with_index do |letter, index|
        # replace blank values with letter if they match a letter in the word we are guessing
        if letter == "_" && @words.first[index] == last_guess
          new_teaser[index] = last_guess
        end
      end

      @word_teaser = new_teaser.join(' ')
  end

end

game = Hangman.new
game.begin