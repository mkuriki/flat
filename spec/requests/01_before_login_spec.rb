require 'rails_helper'

RSpec.describe "ユーザログイン前のテスト", type: :system do
    describe 'トップ画面のテスト' do
      before do
        visit root_path
      end
      
      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/'
        end
        it '「投稿をチェック」リンクが表示される' do
          index_link = find_all('a')[4].native.inner_text
          expect(index_link).to match(/投稿をチェック/)
        end
        it '「投稿をチェック」リンクの内容が正しい' do
          expect(page).to have_link '投稿をチェック', href: public_posts_path
        end
      end
    end
    
    describe 'サイトについて画面のテスト' do
      before do
        visit public_about_path
      end
      
      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/public/about'
        end
      end
    end
    
    describe 'ヘッダーのテスト: ログインしていない場合' do
      before do
        visit root_path
      end
      
      context '表示内容の確認' do
        it 'リンクが表示される: 左上から1番目のリンクが「サイトについて」である' do
          about_link = find_all('a')[1].native.inner_text
          expect(about_link).to match(/サイトについて/)
        end
        it 'リンクが表示される: 左上から2番目のリンクが「新規登録」である' do
          sign_in_link = find_all('a')[2].native.inner_text
          expect(sign_in_link).to match(/新規登録/)
        end
        it 'リンクが表示される: 左上から3番目のリンクが「ログイン」である' do
          log_in_link = find_all('a')[3].native.inner_text
          expect(log_in_link).to match(/ログイン/)
        end
      end
      
      context 'リンクの内容を確認' do
        subject { current_path }
        
        it 'サイトについてを押すと、サイトについて画面に遷移する' do
          about_link = find_all('a')[1].native.inner_text
          about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link about_link
          is_expected.to eq "/public/about"
        end
        it '新規登録を押すと、新規登録画面に遷移する' do
          about_link = find_all('a')[2].native.inner_text
          about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link about_link
          is_expected.to eq "/user/sign_up"
        end
        it 'ログインを押すと、ログイン画面に遷移する' do
          about_link = find_all('a')[3].native.inner_text
          about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link about_link
          is_expected.to eq "/user/sign_in"
        end
      end
    end
    
    describe 'ユーザー新規登録のテスト' do
      before do
        visit new_user_registration_path
      end
      
      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/user/sign_up'
        end
        it '「新規登録」と表示される' do
          expect(page).to have_content '新規登録'
        end
        it 'nameフォームが表示される' do
          expect(page).to have_field 'user[name]'
        end
        it 'last_nameフォームが表示される' do
          expect(page).to have_field 'user[last_name]'
        end
        it 'first_nameフォームが表示される' do
          expect(page).to have_field 'user[first_name]'
        end
        it 'emailフォームが表示される' do
          expect(page).to have_field 'user[email]'
        end
        it 'passwordフォームが表示される' do
          expect(page).to have_field 'user[password]'
        end
        it 'password_confirmationフォームが表示される' do
          expect(page).to have_field 'user[password_confirmation]'
        end
        it 'phone_numberフォームが表示される' do
          expect(page).to have_field 'user[phone_number]'
        end
      end
      
      # context '新規登録成功のテスト' do
      #   before do
      #     fill_in 'user[name]', with: Faker::Name.name
      #     fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 10)
      #     fill_in 'user[first_name]', with: Faker::Lorem.characters(number: 10)
      #     fill_in 'user[phone_number]', with: Faker::Lorem.characters(number: 10)
      #     fill_in 'user[email]', with: Faker::Internet.email
      #     fill_in 'user[password]', with: 'password'
      #     fill_in 'user[password_confirmation]', with: 'password'
      #   end
        
      #   it '正しく新規登録される' do
      #     expect { click_button '新規登録' }.to change(User.all, :count).by(1)
      #   end
      #   it '新規登録後のリダイレクト先が、新規登録できたユーザーの詳細画面になっている' do
      #     click_button '新規登録'
      #     expect(current_path).to eq 'public/users/' + User.last.id.to_s
      #   end
      # end
    end
end