require 'rails_helper'

RSpec.describe Group, type: :model do
  it "有効なグループ内容の場合は保存されるか" do
    expect(build(:group)).to be_valid
  end
end
