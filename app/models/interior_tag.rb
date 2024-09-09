# == Schema Information
#
# Table name: interior_tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_interior_tags_on_name  (name) UNIQUE
#
class InteriorTag < ApplicationRecord
  has_many :post_interior_tags, dependent: :destroy
  has_many :posts, through: :post_interior_tags

  validates :name, presence:true, length:{maximum:50}
end
