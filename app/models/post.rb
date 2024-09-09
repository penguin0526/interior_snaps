# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  post_image :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_interior_tags, dependent: :destroy
  has_many :interior_tags, through: :post_interior_tags
  belongs_to :user
  has_many_attached :images

  validates :title, presence: true
  validates :images, presence: true
  validates :body, presence: true

  def save_interior_tags(tags)
    current_tags = self.interior_tags.pluck(:name) unless self.interior_tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.interior_tags.delete InteriorTag.find_by(name:old_name)
    end

    new_tags.each do |new_name|
      interior_tag = InteriorTag.find_or_create_by(name:new_name)
      self.interior_tags << interior_tag
    end
  end
end
