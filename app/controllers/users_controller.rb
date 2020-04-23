class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :enter,:games,:cashout, :recharge]
  before_filter :validate_casino_id, only:[:enter]


  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end


  def enter# setting current casino
      @user.casino_id=casino_id
      if @user.save
       render :json => {:message =>'Successfully entered the casino',:user=> @user}
      else
       render :json => {:message => @user.errors}
      end
      
  end


  def games
      begin
       @casino=Casino.find(@user.casino_id)
       render :json => {:success => true, :games => @casino.active_games}
     rescue
       render :json => {:success => true, :message => 'You have to enter the casino to see the list of games'}
      end

  end    

  def recharge
    
    begin
     @user.balance=@user.balance+recharge_params[:recharge]
     if @user.save
          render :json => {:success => true, :user => @user}
    else
          render :json => {:success=> false, :message => @user.errors }
    end
  rescue
          render :json => {:success=> false, :message => 'Invalid Params' }

  end


  end
 

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
       render :json => {:success => true, :user => @user}
    else
       render :json => {:success => false, :message => @user.errors}
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end



  def cashout  
   @thrownnumber=Game.find(params[:game_id]).thrownnumber
   if @thrownnumber.nil?
       render :json => {:success => true, :message => 'The dealer is yet to throw the ball'}
   else
     @bets= @user.bets.where(betstatus:'active',game_id: params[:game_id],betnumber: @thrownnumber)   #bets we won
     @totalamt=0
     @bets.each do |bet|
      bet.amountwon=bet.betamount * 2
      @totalamt+=bet.amountwon
      bet.betstatus='won'
      bet.save
     end

     @lostbets= @user.bets.where(betstatus:'active',game_id:params[:game_id])  #bets we lost
     @lostbets.each do |bet|
      bet.betstatus='lost'
      bet.save
     end

      if @totalamt > 0
        @user.balance=@user.balance+@totalamt
        @user.casino.balance=@user.casino.balance-@totalamt 
        @user.save
      end
      render :json => {:success => true,:thrownnumber => @thrownnumber,:bets_won => @bets, :bets_lost => @lostbets, :TotalamountWon => @totalamt,:message=> 'The  amount won will be added to your balance'}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def validate_casino_id
      begin
       @casino=Casino.find(casino_id)
     rescue
       render json: @user.errors, status: :created, location: @user
      end

    end

   

    def casino_id
      params[:user][:casinoid]
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :balance)
    end

    def recharge_params
      params.require(:user).permit(:recharge)
    end


end
