require 'rails_helper'

RSpec.describe Comment, type: :comment do
  describe 'バリデーション' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
    it 'コメント文は必須なこと' do
      comment = post.comments.build(body: nil, user: user)
      comment.valid?
      expect(comment.errors[:body]).to include 'を入力してください'
    end

    it 'コメント分は1000文字いないであること' do
      comment = post.comments.build(body: 'a' * 1001, user: user)
      comment.valid?
      expect(comment.errors[:body]).to include 'は1000文字以内で入力してください'
    end
  end
end
