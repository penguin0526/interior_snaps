# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(email: 'admin@example.pom') do |admin|
  admin.password = 'password'
end

penguin = User.find_or_create_by!(email: "penguin@example.com") do |user|
  user.name = "Penguin"
  user.password = "password"
end

mga = User.find_or_create_by!(email: "mga@example.com") do |user|
  user.name = "Mga"
  user.password = "password"
end

kazunari = User.find_or_create_by!(email: "Kazunari@example.com") do |user|
  user.name = "Kazunari"
  user.password = "password"
end

Post.find_or_create_by!(title: "黒モダンな部屋") do |post|
  post.images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg")
  post.body = "こんな部屋に住みたい"
  post.user = penguin
end