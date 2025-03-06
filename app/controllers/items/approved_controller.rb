class Items::ApprovedController < ApplicationController

  def index
    @items = Item.approved.order(id: :desc)
    @item = Item.new

  end
end