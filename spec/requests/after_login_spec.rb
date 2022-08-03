require 'rails_helper'

RSpec.describe 'ユーザーログイン後のテスト', type: :system do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user)}
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }
  let!(:group) { create(:group, post: post) }
  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }
      
      # it 'postsを押すと、投稿一覧画面に遷移する' do
      #   posts_link = find_all('a')[1].native.inner_text
      #   posts_link = posts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link posts_link
      #   is_expected.to eq '/posts'
      # end

      # it 'マイページを押すと、自分のユーザ詳細画面に遷移する' do
      #   mypage_link = find_all('a')[2].native.inner_text
      #   mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      #   click_link mypage_link
      #   is_expected.to eq '/public/users/' + user.id.to_s
      # end
    end
  end
  
  describe '投稿一覧画面のテスト' do
    before do
      visit  public_posts_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/public/posts'
      end
      it '投稿するボタンが表示されているか' do
        expect(page).to have_selector('a', text: '投稿する')
	    end
    #   it '投稿するボタンのリンク先が正しい' do
    #     expect(page).to have_link post.id.to_s, href: public_post_path(post.id.to_s)
	   # end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: public_user_path(post.user)
        expect(page).to have_link '', href: public_user_path(other_post.user)
      end
      it '自分と他人の投稿画像のリンク先が正しい' do
        expect(page).to have_link '', href: public_post_path(post.user.id.to_s)
        expect(page).to have_link '', href: public_post_path(other_post.user.id.to_s)
      end
      it '自分の投稿と他人の投稿のタイトル(title)のリンク先がそれぞれ正しい' do
        expect(page).to have_link post.title, href: public_post_path(post)
      end
      it '自分と他人のニックネーム(name)のリンク先がそれぞれ正しい' do
        expect(page).to have_link user.name, href: public_user_path(user)
      end
      it '自分の投稿と他人の投稿の本文(body)が表示される' do
        expect(page).to have_content post.body
        expect(page).to have_content other_post.body
      end
    end
    
    describe '新規投稿画面のテスト' do
      before do
        visit new_public_post_path
      end
      
      context '表示内容の確認' do
      #   it '「投稿フォーム」と表示される' do
      #     expect(page).to have_content '投稿フォーム'
      #   end 
      #   it 'titleフォームが表示される' do
      #     expect(page).to have_field 'post[title]'
      #   end        
      #   it 'titleフォームに値が入っていない' do
      #     expect(find_field('post[title]').text).to be_blank
      #   end
      #   it 'bodyフォームが表示される' do
      #     expect(page).to have_field 'post[body]'
      #   end        
      #   it 'bodyフォームに値が入っていない' do
      #     expect(find_field('post[body]').text).to be_blank
      #   end
      end
    
      context '投稿成功のテスト' do
        before do
          fill_in 'post[title]', with: Faker::Lorem.characters(number: 5)
          fill_in 'post[body]', with: Faker::Lorem.characters(number: 20)
          fill_in date {'2020/10/01'}
         end
         
        # it '自分の新しい投稿が正しく保存される' do
        #   expect { click_button '投稿する' }.to change(user.posts, :count).by(1)
        # end
        # it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        # click_button '投稿する'
        # expect (current_path).to eq '/public/posts' + Post.last.id.to_s
        # end
      end
    end
  end
  
  describe  '自分の投稿詳細のテスト' do
    before do
      visit public_post_path(post)
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq 'public/posts/' + post.id.to_s
      end
      it '自分（name）のリンク先がそれぞれ正しい' do
        expect(page).to have_link user.name, href: public_user_path(user)
      end
      it '自分の投稿の本文(body)が表示される' do
        expect(page).to have_content post.body
      end
      it '自分の投稿のタイトル(title)が表示される' do
        expect(page).to have_content post.title
      end
      it 'グループ名（name）のリンク先がそれぞれ正しい' do
        expect(page).to have_link group.name, href: public_post_group_path(post, group)
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '投稿編集', href: edit_public_post_path(post)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '投稿削除', href: public_post_path(post)
      end
    end
    
    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '投稿編集'
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
    end
  end
end