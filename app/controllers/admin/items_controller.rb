class Admin::ItemsController < Admin::BaseController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if params[:item][:image_path] == "" || params[:item][:image_path].nil?
      @item.image_path = "garbage.jpg"
    end
    if @item.save
      flash[:good_message] = "Successfully added a new item to your garbage shop"
      redirect_to item_path(@item)
    else
      flash[:bad_message] = "Creation failed"
      redirect_to new_admin_item_path
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if !params[:item][:active]
      @item.active = false
    end
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      redirect_to edit_admin_item_path(@item)
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :image_path, :active, :category_id)
  end

end
