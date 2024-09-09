# == Schema Information
#
# Table name: post_interior_tags
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  interior_tag_id :integer          not null
#  post_id         :integer          not null
#
# Indexes
#
#  index_post_interior_tags_on_interior_tag_id              (interior_tag_id)
#  index_post_interior_tags_on_post_id                      (post_id)
#  index_post_interior_tags_on_post_id_and_interior_tag_id  (post_id,interior_tag_id) UNIQUE
#
# Foreign Keys
#
#  interior_tag_id  (interior_tag_id => interior_tags.id)
#  post_id          (post_id => posts.id)
#
class PostInteriorTag < ApplicationRecord
  belongs_to :post
  belongs_to :interior_tag
end
