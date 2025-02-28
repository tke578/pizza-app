class ToppingsController < ApplicationController
  before_action :set_topping, only: [:show, :edit, :update, :destroy]
  access [User::PIZZA_STORE_OWNER] => :all

  # GET /toppings
  def index
    @toppings = Topping.all
  end

  # GET /toppings/1
  def show
  end

  # GET /toppings/new
  def new
    @topping = Topping.new
  end

  # GET /toppings/1/edit
  def edit
  end

  # POST /toppings
  def create
    @topping = Topping.new(topping_params)

    if @topping.save
      redirect_to @topping, notice: 'Topping was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /toppings/1
  def update
    if @topping.update(topping_params)
      redirect_to @topping, notice: 'Topping was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /toppings/1
  def destroy
    @topping.destroy!
    redirect_to toppings_url, notice: 'Topping was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topping
      @topping = Topping.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def topping_params
      params.require(:topping).permit(:name)
    end
end
