class VotesController < ApplicationController
  # TODO: should put this on application_controller instead
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @vote = Vote.new
    @vote.user = current_user
    @vote.item = @item
    @vote.save
    @votecount = @item.votes

    # 💙
    respond_to do |format|
      format.html
      format.json { render json: { votecount: @votecount } }
    end

    authorize @vote
  end

  def destroy
    @item = Item.find(params[:id])
    @vote = @item.selected_vote(current_user)
    @vote.destroy
    @votecount = @item.votes

    # 💙
    respond_to do |format|
      format.html
      format.json { render json: { votecount: @votecount } }
    end

    authorize @vote
  end
end
