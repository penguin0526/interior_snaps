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
require "test_helper"

class InteriorTagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
