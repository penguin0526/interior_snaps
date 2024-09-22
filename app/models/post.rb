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
  attr_accessor :name

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :post_interior_tags, dependent: :destroy
  has_many :interior_tags, through: :post_interior_tags
  belongs_to :user
  has_many_attached :images

  validates :title, presence: true
  validates :images, presence: true
  validates :body, presence: true

  after_find :set_name
  after_save :update_tags

  def self.items_serach(search)
   Post.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  end

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

  def content
    # 適切な値を返すように実装する
    body
  end

  private

  def update_tags
    if name.present?
      current_tags = interior_tags.pluck(:name)
      tags = name.gsub(/[[:space:]]/, "").split(",")
      old_tags = current_tags - tags
      new_tags = tags - current_tags

      old_tags.each do |old_name|
        interior_tag = InteriorTag.find_by(name: old_name)
        post_interior_tag = post_interior_tags.find_by(interior_tag_id: interior_tag.id)
        post_interior_tag&.destroy
        interior_tag.destroy if interior_tag.post_interior_tags.size < 1
      end

      new_tags.each do |new_name|
        interior_tag = InteriorTag.find_or_create_by(name: new_name)
        self.interior_tags << interior_tag
      end
    end
  end

  def set_name
    tag_names = self.interior_tags.pluck(:name).join(", ")
    self.name = tag_names
  end

  scope :from_interior_tag, -> (interior_tag_id)  { where(id: post_ids = PostInteriorTag.where(interior_tag_id: interior_tag_id).select(:post_id))}

end