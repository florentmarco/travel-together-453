class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @vote = Vote.new
    @vote.user = current_user
    @vote.item = @item
    @vote.save
    @votecount = @item.votes

    respond_to do |format|
      format.html
      format.json { render json: { votecount: @votecount } }
    end

    authorize @vote
    authorize @item
    authorize @votecount
  end

  def destroy
    @item = Item.find(params[:id])
    @vote = @item.votes.select { |vote| vote.user = current_user }
    @vote.destroy
    @votecount = @item.votes

    respond_to do |format|
      format.html
      format.json { render json: { votecount: @votecount } }
    end

    authorize @vote
    authorize @item
    authorize @votecount
  end

  # private

  # def vote_params
  #   params.require(:votes).permit()
  # end
end
