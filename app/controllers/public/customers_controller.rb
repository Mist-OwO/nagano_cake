class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = Customer.find(params[:id])
  end

  def unsubscribe
    
  end
  
  def withdraw

  end

  def edit

  end
  
  def update

  end
end
