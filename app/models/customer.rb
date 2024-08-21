# == Schema Information
#
# Table name: customers
#
#  id                 :integer          not null, primary key
#  email              :string
#  encrypted_password :string
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Customer < ApplicationRecord
end
