class VotesController < ApplicationController
  before_action :logged_in_user, only: [:up_vote, :down_vote]

  def up_vote
    @vote=Vote.find_by(votable_params)

    if @vote.nil?
      @vote=current_user.votes.new(votable_params)
    end
    
    @vote.upvote
    @votable=@vote.votable
    @user=@votable.user
    votable_rep(@votable)
    user_rep(@user)
    redirect_back(fallback_location: root_path)
    end

  def down_vote
    @vote=Vote.find_by(votable_params)
    if @vote.nil?
      @vote=current_user.votes.new(votable_params)
    end
    @vote.downvote
    @votable=@vote.votable
    @user=@votable.user
    votable_rep(@votable)
    user_rep(@user)
    redirect_back(fallback_location: root_path)
  end

  private

  def votable_params
    params.permit(:votable_id,:votable_type,:user_id)
  end

  def votable_rep(votable)
    votable.update(votes_rep:votable.vote.where("vote is true").count-votable.vote.where("vote is false").count)
  end

end


