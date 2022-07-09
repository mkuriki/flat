require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it "有効なお気に入り内容の場合は保存されるか" do
    expect(build(:favorite)).to be_valid
  end
end
