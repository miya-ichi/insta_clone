class LikesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @post = Post.find(params[:post_id])
    # いいねの作成に成功したらメーラーを呼び出す。deliver_laterメソッドを使用することで、非同期でメールを送信する。
    UserMailer.with(user_from: current_user, user_to: @post.user, post: @post).like_post.deliver_later if current_user.like(@post) && @post.user.notification_on_like?
  end

  def destroy
    @post = Like.find(params[:id]).post
    current_user.unlike(@post)
  end
end
