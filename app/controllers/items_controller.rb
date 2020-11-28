class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    # status filter function
    if params[:pending].present?
      @items = policy_scope(Item).search_by_status('Pending').search_by_id(params[:trip_id])
    elsif params[:approved].present?
      @items = policy_scope(Item).search_by_status('Approved').search_by_id(params[:trip_id])
    elsif params[:booked].present?
      @items = policy_scope(Item).search_by_status('Booked').search_by_id(params[:trip_id])
    else
      @items = policy_scope(Item).search_by_id(params[:trip_id])
    end
    render partial: 'items/items', locals: { items: @items }
  end
end
