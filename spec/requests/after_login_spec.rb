require 'rails_helper'

RSpec.describe 'ユーザーログイン後のテスト', type: :system do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user)}
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      # it 'マイページを押すと、自分のユーザ詳細画面に遷移する' do
      #   mypage_link = find_all('a')[2].native.inner_text
      #   mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link mypage_link
      #   is_expected.to eq '/public/users/' + user.id.to_s
      # end
    end
  end
end