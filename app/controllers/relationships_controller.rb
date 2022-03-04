class RelationshipsController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    # リクエストに含まれる（フォローする人の）IDからフォローするユーザーを取得
    @user = User.find(params[:followed_id])
    UserMailer.with(user_from: current_user, user_to: @user).follow.deliver_later if current_user.follow(@user)
  end

  def destroy
    # Relationshipテーブルからフォローされているユーザーを取得
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
