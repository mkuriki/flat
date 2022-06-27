class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]#検索範囲
    @word = params[:word]#検索ワード
    @search = params[:search]#検索メソッド
    @posts = Post.all

    if @range == 'User'
      @users = User.search_for(@search, @word)
    elsif @range == 'Post'
      @posts = Post.search_for(@search, @word)
    elsif @range == 'Tag'
      @posts = Tag.search_posts_for(@search, @word)
    end
  end
end
