require 'rails_helper'

RSpec.describe PostComment, type: :model do
  it "有効なコメント内容の場合は保存されるか" do
    expect(build(:post_comment)).to be_valid
  end
end
