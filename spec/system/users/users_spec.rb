require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  describe 'ユーザー登録' do
    context '入力情報が正しい場合' do
      it 'ユーザー登録できること' do
        visit new_user_path
        fill_in 'ユーザー名', with: 'Rails太郎'
        fill_in 'メールアドレス', with: 'rails@example.com'
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード(確認)', with: '12345678'
        click_button '登録'
        expect(current_path).to eq root_path
        expect(page).to have_content 'ユーザーを作成しました'
      end
    end

    context '入力情報に誤りがある場合' do
      it 'ユーザー登録に失敗すること' do
        visit new_user_path
        fill_in 'ユーザー名', with: ''
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        fill_in 'パスワード(確認)', with: ''
        click_button '登録'
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'パスワードは3文字以上で入力してください'
        expect(page).to have_content 'パスワード(確認)を入力してください'
        expect(page).to have_content 'ユーザーの作成に失敗しました'
      end
    end
  end
end