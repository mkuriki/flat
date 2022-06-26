class Group < ApplicationRecord
    #アソシエーション
    belongs_to :post#, dependent: :destroy

    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users, dependent: :destroy

    #一枚の画像添付
    has_one_attached :group_image

    #バリデーション
    validates :name, length: { maximum: 20 }, presence: true
    validates :introduction, presence: true

    #グループ画像
    def get_group_image(width, height)
      unless group_image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        group_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
      end
        group_image.variant(resize_to_limit: [width, height]).processed
    end

    #ユーザーがグループ作成者であるかどうか
    def is_owned_by?(user)
      owner_id == user.id
    end
end
