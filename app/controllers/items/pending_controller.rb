class Items::PendingController < ApplicationController

  def index
    @items = Item.pending.order(id: :desc)
    @item = Item.new

  end
end