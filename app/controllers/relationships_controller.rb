class RelationshipsController < ApplicationController

    #フォローする
    def create
      current_user.follow(params[:id])
      redirect_to user_path(params[:id])
    end

    # アンフォローする
    def destroy
      current_user.unfollow(params[:id])
      redirect_to user_path(params[:id])
    end

end
