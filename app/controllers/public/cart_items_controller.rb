  class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!, only: [:create, :index, :update, :destroy, :destroy_all]
  
    def create
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.item_id = params[:cart_item][:item_id]
      @cart_item.customer_id = params[:cart_item][:customer_id]
      if @cart_item.save
        redirect_back(fallback_location: root_path)
      else
        redirect_back(fallback_location: root_path)
      end
    end
  
    def index
      @cart_items = CartItem.where(customer_id: current_customer.id)
    end
  
    def update
      @cart_item = CartItem.find(params[:id])
      if @cart_item.update(cart_item_params)
        redirect_to cart_items_path
      else
        @cart_items = CartItem.where(customer_id: current_customer.id)
        render :index
      end
    end
  
    def destroy
      @cart_item = CartItem.find(params[:id])
      @cart_item.destroy
      redirect_back(fallback_location: root_path)
    end
  
    def destroy_all
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        cart_item.destroy
      end
      redirect_to items_path
    end
  
    private
  
      def cart_item_params
        params.require(:cart_item).permit(:customer_id, :item_id, :amount)
      end
  
  end