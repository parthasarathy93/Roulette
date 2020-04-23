class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :update, :destroy]
  before_action :set_user, only: [:create]


  # GET /bets
  def index
    @bets = Bet.all

    render json: @bets
  end

  # GET /bets/1
  def show
    render json: @bet
  end

  # POST /bets
  def create
    if is_game_open
      @bet=@user.bets.build(bet_params)
      @user.balance=@user.balance-@bet.betamount
      if(@user.balance >=0)
         if(1..36).include? @bet.betnumber

          @casino=@user.casino
          @casino.balance=@casino.balance+@bet.betamount
          @casino.save
          @user.save
        if @bet.save
            render :json => {:success => true, :bet => @bet}
        else
            render :json => {:success => false, :message => @bet.errors}
        end
      else
                   render :json => {:success => false, :message => 'Your bet number should bet between 1 to 36'}

      end
      else
                   render :json => {:success => false, :message => 'Your bet amount will make your balance negative, please choose a lower amount or recharge your balance '}
      end
    else
               render :json => {:success => false, :message => 'The game is closed by the dealer'}

    end

  end

  # PATCH/PUT /bets/1
  def update
    if @bet.update(bet_params)
      render json: @bet
    else
      render json: @bet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /bets/1
  def destroy
    @bet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def is_game_open
      g=Game.find(bet_params[:game_id])
      g.gamestatus=='start'
    end

    def set_user
       @user=User.find(params[:user_id])
    end

    def set_bet
      @bet = Bet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bet_params
      params.require(:bet).permit(:game_id, :betnumber, :bettime, :betstatus,:betamount)

    end
end
