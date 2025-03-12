class Api::V1::SubscriptionsController < ApplicationController
  def index
    render json: SubscriptionSerializer.new(Subscription.all, fields: {subscription: [:title, :price, :status, :frequency]}).serializable_hash, status: :ok
  end

  def show
    subscription = Subscription.find(params[:id])
    render json: SubscriptionSerializer.new(subscription, include: [:teas, :customers]).serializable_hash, status: :ok
  end

  def update
    validate_status = Subscription.valid_status?(params[:id])
    if validate_status
      render json: Subscription.update(params[:id], params.require(:subscription).permit(:status)), status: :ok
    else
      render json: ErrorSerializer.format_error({message: "Subscription already canceled!", status: 400}), status: :bad_request
    end
  end
end