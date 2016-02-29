# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "-- Users"
user1 = User.create!(email: 'a@abc.com', first_name: 'Alexandre', last_name: 'Dumas', password: '123soleil', password_confirmation: '123soleil')
user2 = User.create!(email: 'b@abc.com', first_name: 'Charles', last_name: 'Bukowski', password: '123soleil', password_confirmation: '123soleil')
user3 = User.create!(email: 'c@abc.com', first_name: 'Ernest', last_name: 'Hemingway', password: '123soleil', password_confirmation: '123soleil')
user4 = User.create!(email: 'd@abc.com', first_name: 'Truman', last_name: 'Capote', password: '123soleil', password_confirmation: '123soleil')
user5 = User.create!(email: 'e@abc.com', first_name: 'Guillaume', last_name: 'Apollinaire', password: '123soleil', password_confirmation: '123soleil')
user6 = User.create!(email: 'f@abc.com', first_name: 'Niccolo', last_name: 'Machiavelli', password: '123soleil', password_confirmation: '123soleil')
user7 = User.create!(email: 'g@abc.com', first_name: 'Gustave', last_name: 'Flaubert', password: '123soleil', password_confirmation: '123soleil')
user8 = User.create!(email: 'h@abc.com', first_name: 'Françoise', last_name: 'Sagan', password: '123soleil', password_confirmation: '123soleil')
user9 = User.create!(email: 'i@abc.com', first_name: 'Ferdinand', last_name: 'Celine', password: '123soleil', password_confirmation: '123soleil')
user10 = User.create!(email: 'j@abc.com', first_name: 'Boris', last_name: 'Vian', password: '123soleil', password_confirmation: '123soleil')

puts "-- Experiences"
experience1 = user1.experiences.create!(category:'Restaurant', description:'Laccueil, le service, la table avec vue sur le patio et bien sûr la cuisine, tout est sublime. Chaque plat est une merveille.', address:'1145 mulholland drive los angeles', title: 'Lynch like')
experience2 = user2.experiences.create!(category:'Bar', description:'la table avec vue sur le patio et bien sûr la cuisine, tout est sublime. Chaque plat est une merveille.', address:'336 rose avenue Venice beach California', title: 'Fabulous like')
experience3 = user3.experiences.create!(category:'Leisure', description:' avec vue sur le patio et bien sûr la cuisine, tout est sublime. Chaque plat est une merveille.', address:'8221 Sunset Blvd, Los Angeles, CA 90046, United States', title: 'Paradise like')
experience4 = user4.experiences.create!(category:'Sport', description:' le patio et bien sûr la cuisine, tout est sublime. Chaque plat est une merveille.', address:'２, ３丁目-７-１ 西新宿 新宿区 東京都 163-1055, Japan', title: 'Lost in translation like')
experience5 = user5.experiences.create!(category:'Bar', description:' bien sûr la cuisine, tout est sublime. Chaque plat est une merveille.', address:'Giudecca, 10, 30133 Venezia, Italy', title: 'Orgasmic like')
experience6 = user6.experiences.create!(category:'Restaurant', description:'vue sur le patio et bien sûr la cuisine, tout est sublime. Chaque plat est une merveille.', address:'147 Mercer St, New York, NY 10012, United States', title: 'Gloomy like')

puts "-- Reviews"
review1 = user7.ratings.create!(experience_id: experience4.id, rating:5, review:'Hell in Heaven')
review2 = user9.ratings.create!(experience_id: experience2.id, rating:5, review:'Galactic in Heaven')
review3 = user10.ratings.create!(experience_id: experience4.id, rating:5, review:'Joy in Heaven')

puts "-- Wishlists"
wishlist = user6.wishlists.create!(experience_id: experience3.id)
wishlist2 = user1.wishlists.create!(experience_id: experience2.id)
wishlist3 = user2.wishlists.create!(experience_id: experience3.id)
wishlist4 = user3.wishlists.create!(experience_id: experience4.id)



