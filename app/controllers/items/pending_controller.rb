class Items::PendingController < ApplicationController

  def index
    @items = Item.pending.order(id: :desc)
    @item = Item.new
  end

  def update
    @item = Item.find(params[:id])
    @item.pending!

    respond_to do |format|
      #format.turbo_stream { render turbo_stream.refresh @item }
      format.html { redirect_to items_path }
    end
  end
end