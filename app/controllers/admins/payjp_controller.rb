class Admins::PayjpController < Admins::Base
  
  def index
  end

  def user_index
    @search_params = user_search_params
    @users = User.search(@search_params).page(params[:page]).per(10)
  end

  def user_show
    if params[:format].present?
      @user = Payjp::Customer.retrieve(params[:format])
      @subscription = Subscription.find_by(user_id: params[:user_id])
      @plan = Plan.find(@subscription.plan_id)
   else
      @user = User.find(params[:user_id])
    end
  end

  private

  def user_search_params
    params.fetch(:search, {}).permit(:name)
  end
end
