class ItemsController < ApplicationController
  before_action :set_item, only: %i[ show edit update destroy ]

  # GET /items or /items.json
  def index
    @items = Item.all.order(id: :desc)
    @item = Item.new
  end

  # GET /items/1 or /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    @items = Item.all
    render action: :index
    #render turbo_stream: turbo_stream.replace(@item, partial: "edit_form", locals: { item: @item })
  end

  # POST /items or /items.json
  def create
    @item = Item.new(item_params)
    @items = Item.all.order(id: :desc)

    if @item.save
      #redirect_to items_path, notice: "Item was successfully created."
      render turbo_stream: turbo_stream.update("items", partial: "items/index", locals: { items: @items, item: Item.new })
    else
      render :index, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1 or /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html { redirect_to items_path, notice: "Item was successfully created." }
    end
  end

  # DELETE /items/1 or /items/1.json
  def destroy
    @item.destroy!

    respond_to do |format|
      #format.turbo_stream { render turbo_stream: turbo_stream.remove(@item) }
      format.html { redirect_to items_path, status: :see_other, notice: "Item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.expect(item: [ :sku, :status ])
    end
end
