# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:post) { build(:post, title: 'hoge',body: 'body') }
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に「Make Your Day !!」が表示されているか' do
        expect(page).to have_content 'Make Your Day !!'
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
    end
  end
  describe '一覧画面のテスト' do
    before do
      visit public_posts_path
    end
    context'表示の確認' do
	   it "postの一覧表示と新規投稿フォームのリンクが表示されているか" do

	   end
    end
  end
end
