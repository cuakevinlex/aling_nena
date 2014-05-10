require 'sinatra'
require './boot.rb'
require './money_calculator.rb'

# ROUTES FOR ADMIN SECTION
get '/admin' do
  @products = Item.all
  erb :admin_index
end

get '/new_product' do
  @product = Item.new
  erb :product_form
end

post '/create_product' do
  Item.create!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
    sold: 0
  )
  redirect to '/admin'
end

get '/edit_product/:id' do
  @product = Item.find(params[:id])
  erb :product_form
end

post '/update_product/:id' do
  @product = Item.find(params[:id])
  @product.update_attributes!(
    name: params[:name],
    price: params[:price],
    quantity: params[:quantity],
  )
  redirect to '/admin'
end

get '/delete_product/:id' do
  @product = Item.find(params[:id])
  @product.destroy!
  redirect to '/admin'
end
# ROUTES FOR ADMIN SECTION

# ROUTES FOR CLIENT SECTION

get '/about' do
	erb :about
end

get '/' do
	@products = Item.all
	@count = Item.count -1 
	@listofitems = ""
	@array = Array.new
	while (@array.count < Item.count and @array.count < 10)
		@index = rand(@count)
		@loopc=0
		while (@loopc < @array.count or @array.count == 0)
			@lastindex = @array.count - 1
			if @index == @array[@loopc]
				break
			end
			if @loopc == @lastindex or @array.count == 0
				@array << @index
			end
			@loopc +=1
		end
	end
	@b = 0
	while (@b < 10 and @b <@count)
	@name = @products[@array[@b]].name
	@price = @products[@array[@b]].price
	@listofitems += "<h4>#{@name} - Php #{@price}</h4>"
	@b += 1
	end
	erb :index
end

get '/products' do
	@products = Item.all
	erb :products
end

get '/product/:id' do
	@product = Item.find(params[:id])
	erb :product
end

post '/product/:id' do
	@product = Item.find(params[:id])
	if params[:amount] == "" or params[:ones]  == ""or params[:fives] == "" or params[:tens] == ""or params[:twenties]  == "" or params[:fifties]  == "" or params[:hundreds]  == "" or params[:five_hundreds]  == "" or params[:thousands]  == ""
		erb :product_res_fail2
	else
		@amount = params[:amount].to_i
		@ones = params[:ones]
		@fives = params[:fives]
		@tens = params[:tens]
		@twenties = params[:twenties]
		@fifties = params[:fifties]
		@hundreds = params[:hundreds]
		@five_hundreds = params[:five_hundreds]
		@thousands = params[:thousands]
		@cash_reg = MoneyCalculator.new @ones, @fives, @tens, @twenties, @fifties, @hundreds, @five_hundreds, @thousands
		if @amount.to_i == 1
			@piece = "piece"
		else
			@piece = "pieces"
		end
		@money_paid = @cash_reg.money_paid.to_i
		@money_due = @amount.to_i * @product.price.to_i
		@money_change = @money_paid - @money_due
		if @money_change < 0
			erb :product_res_fail
		elsif @amount > @product.quantity.to_i
			erb :product_res_fail3
		else
			@denominations = @cash_reg.change(@amount, @product.price)
			@change = @cash_reg.money_totalchange
			@paid = @cash_reg.money_paid
			@product.update_attributes!(
		    name: @product.name,
		    price: @product.price,
   			quantity: @product.quantity.to_i - @amount.to_i,
			)
			erb :product_res
		end
	end
end