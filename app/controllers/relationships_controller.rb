class RelationshipsController < ApplicationController

  def follow
    @user = User.find_by(id: params[:id])
    current_user.follow(params[:id])
    #redirect_to user_path(params[:id])
  end


  def unfollow
    @user = User.find_by(id: params[:id])
    current_user.unfollow(params[:id])
    #redirect_to user_path(params[:id])
  end

end
