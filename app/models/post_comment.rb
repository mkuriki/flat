class PostComment < ApplicationRecord
  belongs_to :user#, dependent: :destroy
  belongs_to :post#, dependent: :destroy

  validates :comment, presence: true
end
