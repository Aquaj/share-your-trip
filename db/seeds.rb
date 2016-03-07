# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seed started !"
puts "-- Users"
user1 = User.create!(email: 'a@abc.com', first_name: 'Alexandre', last_name: 'Dumas', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.orderofbooks.com/wp-content/uploads/2013/02/Alexandre-Dumas-pere.jpg")
user2 = User.create!(email: 'b@abc.com', first_name: 'Charles', last_name: 'Bukowski', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://timesquatters.com/wp-content/uploads/2016/01/Charles-Bukowski-10.jpg")
user3 = User.create!(email: 'c@abc.com', first_name: 'Ernest', last_name: 'Hemingway', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.nndb.com/people/790/000022724/loc-hemmingway-2.jpg")
user4 = User.create!(email: 'd@abc.com', first_name: 'Truman', last_name: 'Capote', password: '123soleil', password_confirmation: '123soleil', avatar_url: "https://s-media-cache-ak0.pinimg.com/236x/56/6a/11/566a1148558e825edfce68f4b4ac7962.jpg")
user5 = User.create!(email: 'e@abc.com', first_name: 'Guillaume', last_name: 'Apollinaire', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.anvilpresspoetry.com/assets_cm/FILES/image/APOLLINAIRE.jpg")
user6 = User.create!(email: 'f@abc.com', first_name: 'Niccolo', last_name: 'Machiavelli', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://iicwashington.info/events/20130315/machiavelli2.jpg")
user7 = User.create!(email: 'g@abc.com', first_name: 'Gustave', last_name: 'Flaubert', password: '123soleil', password_confirmation: '123soleil', avatar_url: "https://upload.wikimedia.org/wikipedia/commons/1/17/Flaubert-Giraud.jpg")
user8 = User.create!(email: 'h@abc.com', first_name: 'Françoise', last_name: 'Sagan', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://images.smh.com.au/2010/10/06/1969578/Sagan-420x0.jpg")
user9 = User.create!(email: 'i@abc.com', first_name: 'Ferdinand', last_name: 'Celine', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.greatthoughtstreasury.com/sites/default/files/Celine%5B1%5D.jpg")
user10 = User.create!(email: 'j@abc.com', first_name: 'Boris', last_name: 'Vian', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.nosenchanteurs.eu/wp-content/uploads/2015/05/Boris-Vian.jpg")
puts "-- Done!"

puts "-- Experiences"
puts "  -- Restaurant"
experience_restaurant = user10.experiences.create!(category:'Restaurant',
                                                   description:'Dans une ambiance détendue et familiale où on se sent tout de suite à l\'aise, le patron, Léonard, nous sert ce qui est sans doutes la meilleure pizza de LA.',
                                                   address:'7929 Emerson Ave, Los Angeles, CA 90045',
                                                   country: "United States",
                                                   title: 'The Good Pizza has the Best Pizza ',
                                                   photo_urls: ["http://archives.quarrygirl.com/wp-content/uploads/2009/01/purgatory-pizza-teese-pizza-570x304.jpg", "http://usa.sae.edu/assets/Campuses/Los-Angeles/2015/Los_Angeles_city_view.jpg"])
puts "  -- Bar"
experience_bar        = user9.experiences.create!(category:'Bar',
                                                  description:'Un magnifique bar avec des boissons pour tous les goûts, un service excellent par un personnel adorable !',
                                                  address:'637 10th Ave, New York, NY 10036',
                                                  country: "United States",
                                                  title: 'Je peux pas, j\'ai poney.',
                                                  photo_urls: [ "http://www.barsparis.com/wp-content/uploads/2012/02/harrys-bar-paris-3.jpg"])
puts "  -- Leisure"
experience_leisure    = user8.experiences.create!(category:'Leisure',
                                                  description:'Le meilleur endroit pour se détendre, du repos et du calme dans un décor mangnifique.',
                                                  address:'8221 Sunset Blvd, Los Angeles, CA 90046',
                                                  country:  "United States",
                                                  title: 'Le Château Marmont',
                                                  photo_urls: [ "http://41.media.tumblr.com/1784e615201514f794462c93cb86009f/tumblr_n1xixsKfFp1qaktyno1_1280.jpg", "http://r-ec.bstatic.com/images/hotel/840x460/542/5429184.jpg"])
puts "  -- Sport"
experience_sport      = user7.experiences.create!(category:'Sport',
                                                  description:'Parfait pour les sportifs, moi qui aime me dépenser j\'ai été ravi.',
                                                  address: 'Ramjas College , University of Delhi, 4, Patel Marg, Maurice Nagar 110007, New Delhi',
                                                  country: "India",
                                                  title: 'Jimindia cricket',
                                                  photo_urls: [ "http://www.bandt.com.au/information/uploads/2014/07/shutterstock_114007321-1260x840.jpg, http://www.pedestrian.tv/images/article/2013/11/21/the-cricket-ashes-2013-642-380-619-386.jpg"])
puts "  -- Hotel"
experience_hotel      = user6.experiences.create!(category:'Hotel',
                                                  description:'Un hôtel magnifique, une expérience hors du commun. Un must-see, pour les amateurs de Santori.',
                                                  address:'２, ３丁目-７-１ 西新宿 新宿区 東京都 163-1055',
                                                  country: "Japan",
                                                  title: 'L\'Hôtel de Lost in Translation !',
                                                  photo_urls: [ "https://hotelstationery.files.wordpress.com/2010/11/25e32583259125e3258325bc25e3258225af25e32583258f25e3258225a425e3258225a225e32583258325e32583258825e6259d25b125e425ba25ac.jpeg", "https://media-cdn.tripadvisor.com/media/photo-s/09/d4/e8/90/photo0jpg.jpg"])
puts "  -- Panorama"
experience_panorama   = user5.experiences.create!(category:'Panorama',
                                                  description:'Un pont magnifique dans une ville tout aussi belle, la vue de la Garonne lorsque l\'on se promène dessus est juste exceptionnelle.',
                                                  address:'Pont de Pierre, 33000 Bordeaux',
                                                  country: "France",
                                                  title: 'Le pont le plus connu de Bordeaux.',
                                                  photo_urls: ["http://img0.mxstatic.com/wallpapers/8aa05efb091ce62b400ea2c4c2dc3aab_large.jpeg", "http://www.obs.u-bordeaux1.fr/m2a/soubiran/pont_pierre.JPG", "http://images.sudouest.fr/images/2015/01/29/1812868_8320388_800x400.jpg"])
puts "-- Done!"
puts "  -- Restaurant"
experience_restaurant = user10.experiences.create!(category:'Restaurant',
                                                   description:'Dans une ambiance familiale où on se sent tout de suite à l\'aise, le patron, Olivier, nous sert ce qui est sans doutes la meilleure pizza de LA.',
                                                   address:'8 Place du Palais, Bordeaux',
                                                   country: "France",
                                                   title: 'La Cagette ',
                                                   photo_urls: ["http://www.papillesetpupilles.fr/wp-content/uploads/2014/02/La-cagette.jpg"])
puts "  -- Bar"
experience_bar        = user9.experiences.create!(category:'Bar',
                                                  description:'un service excellent par un personnel adorable !',
                                                  address:' 13 Place du Palais, Bordeaux',
                                                  country: "France",
                                                  title: 'Chez Fred, le bar des Vedettes',
                                                  photo_urls: [ "http://www.gillespudlowski.com/wp-content/uploads/2014/11/l1200186-1024x680.jpg"])
puts "  -- Leisure"
experience_leisure    = user8.experiences.create!(category:'Leisure',
                                                  description:'Cinéma et cantine sympa  dans un décor mangnifique.',
                                                  address:'5 Place Camille Jullian, 33000 Bordeaux',
                                                  country:  "France",
                                                  title: 'Utopia le ciné branchouille',
                                                  photo_urls: [ "http://www.bordeaux-quartiers.fr/wp-content/uploads/2014/02/utopia-bordeaux-cinema.jpg, http://images.sudouest.fr/images/2010/12/25/276015_15259528_460x306.jpg"])
puts "  -- Sport"
experience_sport      = user7.experiences.create!(category:'Sport',
                                                  description:"découvrir de sport magnifique dans un environment de rêve, c'est gratuit",
                                                  address: '1999 Route du Bourrian, 83580 Gassin',
                                                  country: "France",
                                                  title: "Polo sur la presqu'île",
                                                  photo_urls: [ "http://static1.squarespace.com/static/52faa224e4b05c17d93e1b45/t/556383d4e4b0e65363e9b3a3/1432585181693/", "https://blog.sttropezhouse.com/wp-content/uploads/2013/06/polo_club_st_tropez1.jpg", "http://www.poloplus10.com/dt/uploads/2013/07/polo-club-saint-tropez1.jpg"])

puts "-- Done!"

puts "-- Reviews"
review3 = user2.ratings.create!(experience_id: experience_bar.id, rating:4, review: 'Super soirée dans un super bar! Je recommande!')
review1 = user3.ratings.create!(experience_id: experience_restaurant.id, rating:2, review: 'J\'ai trouvé la pizza de Chez Gino bien meilleure.')
review2 = user4.ratings.create!(experience_id: experience_restaurant.id, rating:3, review: 'Bonne pizza et bonne ambiance. Meilleure pizza de LA? Hm.')
review3 = user5.ratings.create!(experience_id: experience_panorama.id, rating:4, review: 'Belle vue mais attention au vent en hiver! Prévoir son écharpe.')
review3 = user6.ratings.create!(experience_id: experience_hotel.id, rating:5, review: 'Grand fan du film, j\'ai été ravi.')
review3 = user7.ratings.create!(experience_id: experience_sport.id, rating:2, review: 'Intense peut-être mais l\'accueil était horrible.')
review3 = user8.ratings.create!(experience_id: experience_leisure.id, rating:5, review: 'Détente totale.')
puts "-- Done!"

puts "-- Wishlists"
wishlist1 = user1.wishlists.create!(experience_id: experience_bar.id)
wishlist2 = user1.wishlists.create!(experience_id: experience_restaurant.id)
wishlist3 = user1.wishlists.create!(experience_id: experience_panorama.id)
wishlist4 = user2.wishlists.create!(experience_id: experience_hotel.id)
wishlist5 = user2.wishlists.create!(experience_id: experience_sport.id)
wishlist6 = user3.wishlists.create!(experience_id: experience_bar.id)
wishlist7 = user3.wishlists.create!(experience_id: experience_leisure.id)
wishlist8 = user3.wishlists.create!(experience_id: experience_sport.id)
wishlist9 = user3.wishlists.create!(experience_id: experience_hotel.id)
wishlist10 = user3.wishlists.create!(experience_id: experience_restaurant.id)
wishlist11 = user4.wishlists.create!(experience_id: experience_restaurant.id)
wishlist12 = user5.wishlists.create!(experience_id: experience_panorama.id)
wishlist13 = user7.wishlists.create!(experience_id: experience_leisure.id)
wishlist14 = user8.wishlists.create!(experience_id: experience_hotel.id)
wishlist15 = user9.wishlists.create!(experience_id: experience_bar.id)
wishlist16 = user9.wishlists.create!(experience_id: experience_restaurant.id)
wishlist17 = user10.wishlists.create!(experience_id: experience_panorama.id)
wishlist18 = user10.wishlists.create!(experience_id: experience_bar.id)
wishlist19 = user10.wishlists.create!(experience_id: experience_restaurant.id)
wishlist20 = user10.wishlists.create!(experience_id: experience_leisure.id)


puts "-- Roadmaps"

roadmap1 = user1.roadmaps.create!
roadmap2 = user1.roadmaps.create!
roadmap3 = user1.roadmaps.create!
roadmap4 = user2.roadmaps.create!
roadmap5 = user2.roadmaps.create!
roadmap6 = user2.roadmaps.create!
roadmap7 = user3.roadmaps.create!
roadmap8 = user3.roadmaps.create!




puts "-- Done!"
puts "Seed done !"
