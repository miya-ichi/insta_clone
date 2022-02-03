class SearchPostsForm
  # 値の代入やバリデーション、コールバックなどを実行できるようにするためにinclude
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :body, :string
  attribute :comment_body, :string
  attribute :username, :string

  def search
    # 全ての投稿を取得(この時点でSQLは走らず、以下の条件別に検索した結果をさらに追加してビューに表示される時に実行される)
    # その際に結果が重複しないようdistinctを使用する
    scope = Post.distinct
    # 検索フォーム（本文）に文字列が入っている場合(=リクエストのパラメータに入っていた場合)
    # スペースで区切られたキーワードを1個ずつに分けて検索し、その結果を合体(表現が適切じゃなさそう)して変数scopeにチェーン
    scope = splited_bodies.map { |splited_body| scope.body_contain(splited_body) }.inject { |result, scp| result.or(scp) } if body.present?
    # 検索フォーム（コメント）に文字列が入っている場合(=リクエストのパラメータに入っていた場合)
    # コメントを検索し、結果を変数scopeにチェーン
    scope = scope.comment_body_contain(comment_body) if comment_body.present?
    # 検索フォーム（ユーザー名）に文字列が入っている場合(=リクエストのパラメータに入っていた場合)
    # ユーザー名を検索し、結果を変数scopeにチェーン
    scope = scope.username_contain(username) if username.present?
    scope
  end

  private

  def splited_bodies
    # stripメソッド・・・文字列の先頭と末尾の空白文字を全て取り除いて生成した文字列を返す
    # それをsplitメソッドにより空白文字で区切られた単語ごとの配列にして返す
    body.strip.split(/[[:blank:]]+/)
  end
end
