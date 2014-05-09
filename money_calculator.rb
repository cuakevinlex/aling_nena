class MoneyCalculator
	attr_accessor :money_paid
	attr_accessor :money_due
	attr_accessor :money_totalchange
	attr_accessor :denominations
  def initialize(ones, fives, tens, twenties, fifties, hundreds, five_hundreds, thousands)
    # each parameter represents the quantity per denomination of money
    # these parameters can be assigned to instance variables and used for computation

    # add a method called 'change' that takes in a parameter of how much an item costs
    # and returns a hash of how much change is to be given
    # the hash will use the denominations as keys and the amount per denomination as values
    # i.e. {:fives => 1, fifties => 1, :hundreds => 3}
    @ones = ones
    @fives = fives
    @tens = tens
    @twenties = twenties
    @fifties = fifties
    @hundreds = hundreds
    @five_hundreds = five_hundreds
    @thousands = thousands
    @money_paid = (@ones.to_i * 1) + (@fives.to_i * 5) + (@tens.to_i * 10) + (@twenties.to_i * 10) +
    	(@fifties.to_i * 50) + (@hundreds.to_i * 100) + (@five_hundreds.to_i * 500) + (@thousands.to_i * 1000)
  end
  
  def change(money_change)
    #denominations = {
    #:ones => @ones,
    #:fives => @fives,
    #:tens => @tens,
    #:twenties => @twenties,
    #:fifties => @fifties,
    #:hundreds => @hundreds,
    #:five_hundreds => @five_hundreds,
    #:thousands => @thousands
    #}
    @ones_c = 0
    @fives_c = 0
    @tens_c = 0
    @twenties_c = 0
    @fifties_c = 0
    @hundred_c = 0
    @five_hundreds_c = 0
    @thousands_c = 0
    @money_change = money_change
	while (@money_change != 0)
    	if @money_change >= 1000
    		@money_change -= 1000
    		@thousands_c += 1
    	elsif @money_change >= 500
    		@money_change -= 500
    		@five_hundreds_c += 1
    	elsif @money_change >= 100
    		@money_change -= 100
    		@hundreds_c += 1
    	elsif @money_change >= 50
    		@money_change -= 50
    		@fifties_c += 1
    	elsif @money_change >= 20
    		@money_change -= 20
    		@twenties_c += 1
    	elsif @money_change >= 10
    		@money_change -= 10
    		@tens_c += 1
    	elsif @money_change >= 5
    		@money_change -= 5
    		@fives_c += 1
    	elsif @money_change >= 1
    		@money_change -= 1
    		@ones_c +=1
    	end
    end
    denominations ={
    :ones => @ones_c,
    :five => @fives_c,
    :tens => @tens_c,
    :twenties => @twenties_c,
    :fifties => @fifties_c,
    :hundreds => @hundreds_c,
    :five_hundreds => @five_hundreds_c,
    :thousands => @thousands_c
    }
    return denominations
  end
	

end