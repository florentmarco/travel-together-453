class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    # status filter function
    if params[:category].present?
      @category_filter = policy_scope(Item).search_by_category(params[:category]).search_by_id(params[:trip_id])
    else
      @category_filter = policy_scope(Item).search_by_id(params[:trip_id])
    end

    if params[:status].present?
      @status_filter = @category_filter.search_by_status(params[:status]).search_by_id(params[:trip_id])
    else
      @status_filter = @category_filter
    end
    @items = @status_filter

    render partial: 'items/items', locals: { items: @items }
  end
end
