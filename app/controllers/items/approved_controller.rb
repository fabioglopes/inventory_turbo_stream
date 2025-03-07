class Items::ApprovedController < ApplicationController

  def index
    @items = Item.approved.order(id: :desc)
    @item = Item.new
  end

  def update
    @item = Item.find(params[:id])
    @item.approve!

    respond_to do |format|
      #format.turbo_stream { render turbo_stream.refresh @item }
      format.html { redirect_to items_path }
    end
  end
end