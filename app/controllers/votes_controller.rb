class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @vote = Vote.new
    @vote.user = current_user
    @vote.item = @item
    @vote.save

    authorize @vote
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    authorize @vote
  end

  # private

  # def vote_params
  #   params.require(:votes).permit()
  # end
end
