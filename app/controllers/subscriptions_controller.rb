class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: :create

  def new
    @plans = Plan.all
  end

  def create
    @subscription = Subscription.new(plan_id: params[:plan_id])
    authorize @subscription

    if @subscription.save_with_payment(params[:stripeToken], params[:stripeEmail])
      redirect_to @subscription, :notice => "Thank you for subscribing as a premium user!"
    else
      flash[:error] = "You are already subscribed as a premium user."
      render :show
    end
  end

  def edit
    @subscription = Subscription.find(params[:user_id])
    authorize @subscription
  end

  def cancel
    @subscription = Subscription.find(params[:user_id])
  end

  def show
    @subscription = Subscription.find(params[:user_id])
    @plan = Plan.find(params[:plan_id])
    name = @plan.name

    authorize @subscription
  end
end