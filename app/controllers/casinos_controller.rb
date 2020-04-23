class CasinosController < ApplicationController
  before_action :set_casino, only: [:show, :update, :destroy, :recharge]

  # GET /casinos
  def index
    @casinos = Casino.all
   
    render :json => {:success=>true, :casinos=> @casinos}
  end

  # GET /casinos/1
  def show
    render :json => {:success=>true, :casinos=> @casino}
  end

  # POST /casinos
  def create
    @casino = Casino.new(casino_params)

    if @casino.save
      render :json => {:success=>true, :casino=> @casino}
    else
      render :json => {:success=> false, :message=> 'Error while registering casino'}
    end
  end

  # PATCH/PUT /casinos/1
  def update
    if @casino.update(casino_params)
      render json: @casino
    else
      render json: @casino.errors, status: :unprocessable_entity
    end
  end

  def active_games
    @casino.dealers.games.where(status='start')
  end

  # DELETE /casinos/1
  def destroy
    @casino.destroy
  end

   def recharge
    if !recharge_params[:recharge].nil?
       @casino.balance=@casino.balance+recharge_params[:recharge].to_f
       if @casino.save  
         render :json => {:success=>true, :casino=> @casino}
       else
          render :json => {:success=> false, :message=> 'Error while recharging casino'}
       end
    else
          render :json => {:success=> false, :message=> 'Invalid /Missing parameter "balance"'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_casino
      @casino = Casino.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def casino_params
      params.require(:casino).permit(:name, :balance)
    end
     
    def recharge_params
     params.require(:casino).permit(:recharge)
     end

   
  
end
