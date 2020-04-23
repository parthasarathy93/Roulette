class DealersController < ApplicationController
  before_action :set_casino , only: [:index,:show,:create,:update]
  before_action :set_dealer, :get_open_game, :get_close_game, only: [:start,:stop,:throw]

  # GET /dealers
  def index
    @dealers = @casino.dealers.all
    render :json => {:success => true , :dealers => @dealers}
  end

  # GET /dealers/1
  def show
    render json: @casino.dealers.find_by_params[:id]
  end

  def start
    if !live_game? # check if any game is aleady in play by that particular dealer
       @game=@dealer.games.new
       @game.gamestatus='start'
       @game.gamestarttime= DateTime.now 
     if @game.save
       render :json => {:success => true , :game => @game}
     else
       render json: @game.errors, status: :unprocessable_entity
     end
    else
       render :json => {:success => false , :message=> 'There is already a open game going on'}
    end
  end


  def stop
    if @curr_open_game.present?
         @curr_open_game.gamestatus='close'
         @curr_open_game.gameendtime= DateTime.now  
      if @curr_open_game.save
       render :json => {:success => true , :game => @curr_open_game}
      else
        render json: @curr_open_game.errors, status: :unprocessable_entity
      end 
   else
           render :json => {:success => false , :message=> 'There are no open games to close the bet'}
   end
     
  end


  def throw
    if @curr_close_game.present?
       @curr_close_game.gamestatus='complete'
       @curr_close_game.thrownnumber=rand(1..36)
       if @curr_close_game.save
          render :json => {:success => true , :game => @curr_close_game}
       else
          render json: @curr_close_game.errors, status: 'Error while throwing the spin'
       end
    else
          render :json => {:success => false , :message => 'No game is in progress, create a game first'}
    end

  end

  # POST /dealers
  def create
    @dealer = @casino.dealers.build(dealer_params)

    if @dealer.save
      render :json => {:success => true , :dealers => @dealer}
    else
      render :json => {:success => true , :dealers => @dealer.errors}
    end
  end

  # PATCH/PUT /dealers/1
  def update
    if @dealer.update(dealer_params)
      render json: @dealer
    else
      render json: @dealer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dealers/1
  def destroy
    @dealer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_casino
      @casino = Casino.find(params[:casino_id])
    end

    def set_dealer
      @dealer = Dealer.find(params[:id])
    end

    def live_game?
       @curr_open_game.present? || @curr_close_game.present? 
    end

    def get_open_game
      @curr_open_game=@dealer.games.where(dealer_id: params[:id],gamestatus:'start').first
    end

    def get_close_game
      @curr_close_game=@dealer.games.where(dealer_id: params[:id],gamestatus:'close').first
    end

    # Only allow a trusted parameter "white list" through.
    def dealer_params
      params.require(:dealer).permit(:name)
    end


    def game_start_params
       params[:gamestatus]='started'
       params[:gamestarttime]=DateTime.now
    end
end
