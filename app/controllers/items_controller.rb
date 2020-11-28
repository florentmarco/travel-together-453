class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:pending].present?
      @items = policy_scope(Item).search_by_status('Approved')
    else
      @items = policy_scope(Item)
    end
    render partial: 'items/items', locals: { items: @items }
  end
end
