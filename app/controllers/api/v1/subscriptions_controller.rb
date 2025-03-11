class Api::V1::SubscriptionsController < ApplicationController
  def index
    render json: SubscriptionSerializer.new(Subscription.all)
  end

  def show
    subscription = Subscription.find(params[:id])
    render json: SubscriptionSerializer.new(subscription, include: [:teas, :customers]).serializable_hash
  end
end