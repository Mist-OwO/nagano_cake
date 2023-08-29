class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def check
    @order=Order.new(order_params)
    if params[:order][:select_address] == "0"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address]== "1"
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
    end
    @order_item = OrderItem.new
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
  end

  def create
    @order = Order.new(order_params)
    if @order.save
       cart_items = current_customer.cart_items.all
       cart_items.each do |cart_item|
        order_items = OrderItem.new
        order_items.item_id = cart_item.item.id
        order_items.order_id = @order.id
        order_items.price = cart_item.item.with_tax_price
        order_items.amount = cart_item.amount
        order_items.save
      end
        current_customer.cart_items.destroy_all
        redirect_to thanks_orders_path
    else
       @order = Order.new(order_params)
       render :new
    end
  end

  def finish

  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :customer_id, :total_price)
  end

end