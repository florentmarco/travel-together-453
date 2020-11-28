class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = policy_scope(Item)






  end
end
