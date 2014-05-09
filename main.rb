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
	@amount = params[:amount]
	@ones = params[:one]
	@fives = params[:fives]
	@tens = params[:tens]
	@fifites = params[:fifties]
	@hundreds = params[:hundreds]
	@five_hundreds = params[:five_hundreds]
	@thousands = params[:thousands]
	@cash_reg = MoneyCalculator.new @ones, @fives, @tens, @twenties, @fifties, @hundreds, @five_hundreds, @thousands
	if @amount.to_i == 1
		@piece = "piece"
	else
		@piece = "pieces"
	end
	@total = @amount.to_i * @product.price.to_i
	@denominations = @cash_reg.change(@total)
	@change = @cash_reg.money_totalchange
	@paid = @cash_reg.money_paid
	@product.update_attributes!(
    name: @product.name,
    price: @product.price,
    quantity: @product.quantity.to_i - @amount.to_i,
    )
    
	erb :product_res
end