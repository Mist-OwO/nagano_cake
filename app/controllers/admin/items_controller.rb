class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end 
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品の保存に成功しました。"
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end 
  
  def show
    @item = Item.find(params[:id])
  end 
  
  def edit
    @item = Item.find(params[:id])
  end 
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "編集に成功しました。"
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = "商品を削除しました。"
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price)
  end
end