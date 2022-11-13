class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word,:guesses, :wrong_guesses , :word_with_guesses

  def initialize(word)
    
    @word = word
    @guesses =''
    @wrong_guesses = ''
    @word_with_guesses = '-' * word.size
  end


  def guess(letter)
    validate(letter)
     i = 0 
     j=0
     k=0
      while i < word.size
        if letter.downcase == word[i].downcase 
          while j<guesses.size
            if letter.downcase == guesses[j].downcase
              return false
            end
           j +=1 
          end 
          @guesses +=letter.downcase
          display()
          return true
        end
        i += 1
      end  
      while k< wrong_guesses.size
        if letter.downcase == wrong_guesses[k].downcase
          return false
        end
       k +=1 
      end 
     @wrong_guesses+=letter.downcase  
    return false    
  end  

  def display()
    i=0
    j=0
    while i < word.size
      while j < guesses.size
         if guesses[j] == word[i]
            word_with_guesses[i]= guesses[j]
         end 
       j+=1
      end
     i +=1 
    end 
    
  end  

  def validate(letter)
    if letter.nil?
      raise ArgumentError.new("Only letters are allowed")
    end  
    unless letter.match?(/[[:alpha:]]/)
      raise ArgumentError.new("Only letters are allowed")
    end
  end 

  def  guess_several_letters(game, manyGuess)
    @word = game.word
    @guesses = game.guesses
    @wrong_guesses= game.wrong_guesses
    @word_with_guesses= game.word_with_guesses
    i =0
    while i< manyGuess.size
     guess(manyGuess[i])
     i +=1
    end

  end  
  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
