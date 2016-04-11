puts "Seed started !"

puts "-- Users"
userjulien = User.create!(email: 'julien@benoit.com', first_name: 'Julien', last_name: 'Benoit', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://static1.puretrend.com/articles/8/91/82/8/@/1033635-j-620x0-1.jpg")
print "     1"
user2 = User.create!(email: 'b@abc.com', first_name: 'Charles', last_name: 'Bukowski', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://timesquatters.com/wp-content/uploads/2016/01/Charles-Bukowski-10.jpg")
print " - 2"
user3 = User.create!(email: 'c@abc.com', first_name: 'Ernest', last_name: 'Hemingway', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.nndb.com/people/790/000022724/loc-hemmingway-2.jpg")
print " - 3"
user4 = User.create!(email: 'd@abc.com', first_name: 'Truman', last_name: 'Capote', password: '123soleil', password_confirmation: '123soleil', avatar_url: "https://s-media-cache-ak0.pinimg.com/236x/56/6a/11/566a1148558e825edfce68f4b4ac7962.jpg")
print " - 4"
user5 = User.create!(email: 'e@abc.com', first_name: 'Guillaume', last_name: 'Apollinaire', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.anvilpresspoetry.com/assets_cm/FILES/image/APOLLINAIRE.jpg")
puts " - 5"
user6 = User.create!(email: 'f@abc.com', first_name: 'Harold', last_name: 'Pinter', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.nobelprize.org/nobel_prizes/literature/laureates/2005/pinter_portrait.jpg")
print "     6"
user7 = User.create!(email: 'g@abc.com', first_name: 'Fréderic', last_name: 'Beigbeder', password: '123soleil', password_confirmation: '123soleil', avatar_url: "https://litterature-fle.wikispaces.com/file/view/a376ea18-d0cf-11dc-b947-c542c2d953ca.jpg/48392639/a376ea18-d0cf-11dc-b947-c542c2d953ca.jpg")
print " - 7"
user8 = User.create!(email: 'h@abc.com', first_name: 'Françoise', last_name: 'Sagan', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://images.smh.com.au/2010/10/06/1969578/Sagan-420x0.jpg")
print " - 8"
user9 = User.create!(email: 'i@abc.com', first_name: 'Ferdinand', last_name: 'Celine', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.greatthoughtstreasury.com/sites/default/files/Celine%5B1%5D.jpg")
print " - 9"
user10 = User.create!(email: 'j@abc.com', first_name: 'Boris', last_name: 'Vian', password: '123soleil', password_confirmation: '123soleil', avatar_url: "http://www.nosenchanteurs.eu/wp-content/uploads/2015/05/Boris-Vian.jpg")
puts " - 10"
puts "-- Done!"

puts "-- Categories"
puts "  -- Hébergement"
cHb = Category.create!(title:"Hébergement")

puts "    -- Hôtel"
cHt = Category.create!(title:"Hôtel", parent_category: cHb)

puts "    -- Autres"
cHa = Category.create!(title:"Autres", parent_category: cHb)

puts "  -- Restauration"
cRs = Category.create!(title:"Restauration")

puts "    -- Restaurant"
cRt = Category.create!(title:"Restaurant", parent_category: cRt)

puts "    -- Sur le pouce"
cRp = Category.create!(title:"Sur le pouce", parent_category: cRt)

puts "  -- Bar/café"
cBc = Category.create!(title:"Bar/café")

puts "    -- De jour"
cBj = Category.create!(title:"De jour", parent_category: cBc)

puts "    -- De nuit"
cBn = Category.create!(title:"De nuit", parent_category: cBc)

puts "  -- Lieu"
cLi = Category.create!(title:"Lieu")

puts "  -- Activité"
cAc = Category.create!(title:"Activité")

puts "    -- Visite"
cAv = Category.create!(title:"Visite", parent_category: cAc)

puts "    -- Activité sportive"
cAs = Category.create!(title:"Activité sportive", parent_category: cAc)

puts "  -- Commerçant local"
cCl = Category.create!(title:"Commerçant local")
puts "-- Done!"


puts "-- Experiences"
puts "  -- Pizza"
experience_pizza      = user10.experiences.create!(category:cRt,
                                                   description:'Dans une ambiance détendue et familiale où on se sent tout de suite à l\'aise, le patron, Léonard, nous sert ce qui est sans doutes la meilleure pizza de LA.',
                                                   address:'7929 Emerson Ave, Los Angeles, CA 90045',
                                                   title: ' The Best Pizza à LA',
                                                   photo_urls: ["http://archives.quarrygirl.com/wp-content/uploads/2009/01/purgatory-pizza-teese-pizza-570x304.jpg", "http://usa.sae.edu/assets/Campuses/Los-Angeles/2015/Los_Angeles_city_view.jpg"])
puts "  -- Poney"
experience_poney      = user9.experiences.create!(category:cBj,
                                                  description:'Un magnifique bar avec des boissons pour tous les goûts, un service excellent par un personnel adorable !',
                                                  address:'637 10th Ave, New York, NY 10036',
                                                  title: "Poney I'am home.",
                                                  photo_urls: [ "http://www.barsparis.com/wp-content/uploads/2012/02/harrys-bar-paris-3.jpg"])
puts "  -- Marmont"
experience_marmont    = user8.experiences.create!(category:cHt,
                                                  description:'Le meilleur endroit pour se détendre, du repos et du calme dans un décor mangnifique.',
                                                  address:'8221 Sunset Blvd, Los Angeles, CA 90046',
                                                  title: 'Le Château Marmont',
                                                  photo_urls: [ "http://41.media.tumblr.com/1784e615201514f794462c93cb86009f/tumblr_n1xixsKfFp1qaktyno1_1280.jpg", "http://r-ec.bstatic.com/images/hotel/840x460/542/5429184.jpg"])
puts "  -- Cricket"
experience_cricket    = user7.experiences.create!(category:cAs,
                                                  description:'Parfait pour les sportifs, moi qui aime me dépenser j\'ai été ravi.',
                                                  address: 'Ramjas College , University of Delhi, 4, Patel Marg, Maurice Nagar 110007, New Delhi',
                                                  title: 'Jimindia cricket',
                                                  photo_urls: [ "http://www.bandt.com.au/information/uploads/2014/07/shutterstock_114007321-1260x840.jpg", "http://www.pedestrian.tv/images/article/2013/11/21/the-cricket-ashes-2013-642-380-619-386.jpg"])
puts "  -- Lost in translation"
experience_lost       = user6.experiences.create!(category:cHt,
                                                  description:'Un hôtel magnifique, une expérience hors du commun. Un must-see, pour les amateurs de Santori.',
                                                  address:'２, ３丁目-７-１ 西新宿 新宿区 東京都 163-1055',
                                                  title: 'L\'Hôtel de Lost in Translation !',
                                                  photo_urls: [ "https://hotelstationery.files.wordpress.com/2010/11/25e32583259125e3258325bc25e3258225af25e32583258f25e3258225a425e3258225a225e32583258325e32583258825e6259d25b125e425ba25ac.jpeg", "https://media-cdn.tripadvisor.com/media/photo-s/09/d4/e8/90/photo0jpg.jpg"])
puts "  -- Pont de pierre"
experience_pierre     = user5.experiences.create!(category:cLi,
                                                  description:'Un pont magnifique dans une ville tout aussi belle, la vue de la Garonne lorsque l\'on se promène dessus est juste exceptionnelle.',
                                                  address:'Pont de Pierre, 33000 Bordeaux',
                                                  title: 'Le pont le plus connu de Bordeaux.',
                                                  photo_urls: ["http://img0.mxstatic.com/wallpapers/8aa05efb091ce62b400ea2c4c2dc3aab_large.jpeg", "http://www.obs.u-bordeaux1.fr/m2a/soubiran/pont_pierre.JPG", "http://images.sudouest.fr/images/2015/01/29/1812868_8320388_800x400.jpg"])
puts "  -- La Cagette"
experience_cagette    = user10.experiences.create!(category:cRt,
                                                   description:'Dans une ambiance familiale où on se sent tout de suite à l\'aise, le patron, Olivier, nous sert ce qui est sans doutes la meilleure pizza de LA.',
                                                   address:'8 Place du Palais, Bordeaux',
                                                   title: 'La Cagette ',
                                                   photo_urls: ["http://www.papillesetpupilles.fr/wp-content/uploads/2014/02/La-cagette.jpg"])
puts "  -- Chez Fred"
experience_fred       = user9.experiences.create!(category:cBc,
                                                  description:'un service excellent par un personnel adorable !',
                                                  address:' 13 Place du Palais, Bordeaux',
                                                  title: 'Chez Fred, le bar des Vedettes',
                                                  photo_urls: [ "http://www.gillespudlowski.com/wp-content/uploads/2014/11/l1200186-1024x680.jpg"])
puts "  -- Utopia"
experience_utopia     = user8.experiences.create!(category:cAc,
                                                  description:'Cinéma et cantine sympa  dans un décor mangnifique.',
                                                  address:'5 Place Camille Jullian, 33000 Bordeaux',
                                                  title: 'Utopia le ciné branchouille',
                                                  photo_urls: [ "http://www.bordeaux-quartiers.fr/wp-content/uploads/2014/02/utopia-bordeaux-cinema.jpg", "http://images.sudouest.fr/images/2010/12/25/276015_15259528_460x306.jpg"])
puts "  -- Polo"
experience_polo       = user7.experiences.create!(category:cAs,
                                                  description:"découvrir de sport magnifique dans un environment de rêve, c'est gratuit",
                                                  address: '1999 Route du Bourrian, 83580 Gassin',
                                                  title: "Polo sur la presqu'île",
                                                  photo_urls: [ "http://static1.squarespace.com/static/52faa224e4b05c17d93e1b45/t/556383d4e4b0e65363e9b3a3/1432585181693/", "https://blog.sttropezhouse.com/wp-content/uploads/2013/06/polo_club_st_tropez1.jpg", "http://www.poloplus10.com/dt/uploads/2013/07/polo-club-saint-tropez1.jpg"])
puts "  -- Banh"
experience_banh       = user10.experiences.create!(category:cRt,
                                                   description:'Le délice de la ville imperiale de Hué cuisine familiale  nous sert ce Banh là une finesse remarquable',
                                                   address:'Ward 6, 57 Hồ Xuân Hương, phường 6, Hồ Chí Minh, Vietnam',
                                                   title: 'Le Banh la de miss Mai ',
                                                   photo_urls: ["http://du-lich.chudu24.com/f/d/100728/banh-nam-dam-da-huong-vi-hue.jpg"])
puts "  -- Jeunesse"
experience_jeunesse   = user9.experiences.create!(category:cBn,
                                                  description:'Xu, un sublime bar avec des cocktails pour tous les goûts, un service excellent !',
                                                  address:'75 Ward, 71 Hai Bà Trưng, Bến Nghé, Hồ Chí Minh, Vietnam',
                                                  title: 'La Jeunesse dorée Saigonaise se presse au porte de ce temple mythique',
                                                  photo_urls: [ "http://media.foody.vn/res/g3/26399/prof/s640x400/foody-mobile-xu-bar-tp-hcm.jpg"])
puts "  -- Robinson"
experience_robinson   = user8.experiences.create!(category:cHt,
                                                  description:' se détendre, du repos et du calme dans un décor mangnifique.',
                                                  address:'Block Ha My Dong B, Điện Dương, Điện Bàn, Quảng Nam, Vietnam',
                                                  title: 'Nam Hai le Luxe à la Robinson',
                                                  photo_urls: [ "http://www.sixsenses.com/assets/six_senses_gyro/content/images/975x660_01_ocean_front_villa.jpg"])
puts "  -- Lunch Lady"
experience_lunch_lady = user7.experiences.create!(category:cRp,
                                                  description:'manger dans la rue comme un local le rêve à Saïgon',
                                                  address: '23 Hoang Sa St., Phuong Da Kao, District 1',
                                                  title: 'The Lunch Lady',
                                                  photo_urls: [ "http://media.tumblr.com/tumblr_lx7at6CG0y1qha2qr.jpg"])
puts "  -- Vespa tour"
experience_vespa_tour = user6.experiences.create!(category:cAv,
                                                  description:'Ce tour de la ville  en vespa vintage lieux atypiques',
                                                  address:'169A Đề Thám, Phạm Ngũ Lão, 1, Hồ Chí Minh, Vietnam',
                                                  title: 'Vespa Vintage tour !',
                                                  photo_urls: [ "http://vivaster.com/media/cache/excursion_slider_photo/images/excursion/photo/img_5662da90f0a3a7_44518193.jpeg", "http://vespaadventures.com/wp-content/uploads/2014/08/slideshow_saigonafterdark-580x385.jpg", "http://vespaadventures.com/wp-content/uploads/2014/08/slideshow_saigonafterdark-580x385.jpg"])
puts "  -- Saigon river"
experience_saigon     = user5.experiences.create!(category:cLi,
                                                  description:'La plus haute tour du Vietnam une vue nocturne sur la Saigon river extra.',
                                                  address:'36 Hồ Tùng Mậu, Bến Nghé Hồ Chí Minh, Vietnam',
                                                  title: 'Saigon Skydeck',
                                                  photo_urls: ["http://www.bitexcofinancialtower.com/wp-content/themes/responsive/core/images/2.jpg"])
puts "  -- Cite impériale"
experience_cite       = user10.experiences.create!(category:cAv,
                                                   description:'Peu de sites méritent autant le détour que ce Palais ',
                                                   address:'cité imperiale, hue, Vietnam',
                                                   title: 'Le Palais Impérial de Hué',
                                                   photo_urls: ["http://blog.crdp-versailles.fr/worldtour/public/Vietnam/Hue/palais_imperial.jpg"])
puts "  -- Phi Banh"
experience_phi_banh   = user9.experiences.create!(category:cBc,
                                                  description:'un personnel adorable un service excellent !',
                                                  address:' 88 Thai Phien, Hôi An, Vietnam',
                                                  title: 'Phi Banh Mi',
                                                  photo_urls: ["https://media-cdn.tripadvisor.com/media/photo-s/0a/56/13/84/phi-banh-mi.jpg"])
puts "  -- Library"
experience_library    = user8.experiences.create!(category:cHt,
                                                  description:"L'hotel est situé dans une toute petite rue calme ce qui reste un luxe dans cette ville si bruyante par les nombreux Klaxons des 2 roues. ",
                                                  address:'133A Nguyen Dinh Chinh Street | Phu Nhuan District, Ho Chi Minh City, Vietnam',
                                                  title: 'The Alcove Library Hotel',
                                                  photo_urls: [ "http://media-cdn.tripadvisor.com/media/photo-o/08/1e/21/b9/the-alcove-library-hotel.jpg"])
puts "  -- Providence"
experience_providence = user7.experiences.create!(category:cHt,
                                                  description:"découvrir de port magnifique dans un environment de rêve, c'est gratuit",
                                                  address: 'Providence, Rhode Island 02912, USA',
                                                  title: "Etape Idéal",
                                                  photo_urls: [ "http://www.5mnaperdre.fr/wp-content/uploads/2014/02/cabane-dans-les-bois.jpg"])
puts "  -- Bulots"
experience_bulots     = user7.experiences.create!(category:cRp,
                                                  description:"découvrir la gastronomie belge de rue les bulots à la Belge",
                                                  address: ' Rue Sainte-Catherine 45, 1000 Bruxelles, Belgium',
                                                  title: "Place Sainte-Catherine les caricolles",
                                                  photo_urls: [ "http://www.agendamagazine.be/sites/default/files/1385_food_noordzee_c_saskia_vanderstichele.jpg"])
puts "  -- Massage"
experience_massage    = user8.experiences.create!(category:cHt,
                                                  description:' Massage, repos et du calme dans un endroit magique.',
                                                  address:'Ninh Vân, tx. Ninh Hòa, Khánh Hòa, Vietnam',
                                                  title: 'Sixsenses Nha Trang',
                                                  photo_urls: [ "http://www.sixsenses.com/assets/six_senses_gyro/content/images/975x660_hilltop_villa5.jpg"])

puts "-- Reviews"
review3 = user2.ratings.create!(experience_id: experience_jeunesse.id, rating:4, review: 'Super soirée dans un super bar! Je recommande!')
review1 = user3.ratings.create!(experience_id: experience_pizza.id, rating:2, review: 'J\'ai trouvé la pizza de Chez Gino bien meilleure.')
review2 = user4.ratings.create!(experience_id: experience_pizza.id, rating:3, review: 'Bonne pizza et bonne ambiance. Meilleure pizza de LA? Hm.')
review3 = user4.ratings.create!(experience_id: experience_vespa_tour.id, rating:4, review: 'Belle vue mais attention à la circulation! Prévoir un casque.')
review3 = user6.ratings.create!(experience_id: experience_lost.id, rating:5, review: 'Grand fan du film, j\'ai été ravi.')
review3 = user7.ratings.create!(experience_id: experience_cricket.id, rating:2, review: 'Intense peut-être mais l\'accueil était horrible.')
review3 = user8.ratings.create!(experience_id: experience_cite.id, rating:5, review: 'Magnifique.')
review3 = user3.ratings.create!(experience_id: experience_fred.id, rating:4, review: 'Super soirée dans un super bar! Je recommande!')
review1 = user2.ratings.create!(experience_id: experience_cagette.id, rating:2, review: 'J\'ai trouvé la pizza de Chez Gino bien meilleure.')
review2 = user5.ratings.create!(experience_id: experience_cagette.id, rating:3, review: 'Bonne pizza et bonne ambiance. Meilleure pizza de Bordeaux? Hm.')
review3 = user10.ratings.create!(experience_id: experience_vespa_tour.id, rating:4, review: 'Belle vue mais attention au vent en hiver! Prévoir son écharpe.')
review3 = user3.ratings.create!(experience_id: experience_lost.id, rating:5, review: 'Pas fan du film, mais j\'ai été ravi aussi.')
review3 = user10.ratings.create!(experience_id: experience_cite.id, rating:2, review: 'Magnifique peut-être mais l\'accueil était horrible.')
review3 = user2.ratings.create!(experience_id: experience_massage.id, rating:5, review: 'Détente totale.')
review1 = user2.ratings.create!(experience_id: experience_vespa_tour.id, rating:2, review: 'J\'ai trouvé le circuit sympa mais il manquait d\'essence dans les vespa dommage.')
review2 = user5.ratings.create!(experience_id: experience_vespa_tour.id, rating:3, review: 'Bonne vespa et bonne ambiance. un peu dangereux tout de même.')

puts "-- Done!"

puts "-- Wishlists"
wishlist1 = userjulien.wishlists.create!(experience_id: experience_cite.id)
wishlist2 = userjulien.wishlists.create!(experience_id: experience_vespa_tour.id)
wishlist10 = userjulien.wishlists.create!(experience_id: experience_bahn.id)
wishlist3 = user5.wishlists.create!(experience_id: experience_pierre.id)
wishlist4 = user2.wishlists.create!(experience_id: experience_lost.id)
wishlist5 = user2.wishlists.create!(experience_id: experience_cricket.id)
wishlist6 = user3.wishlists.create!(experience_id: experience_jeunesse.id)
wishlist7 = user3.wishlists.create!(experience_id: experience_massage.id)
wishlist8 = user3.wishlists.create!(experience_id: experience_polo.id)
wishlist9 = user3.wishlists.create!(experience_id: experience_bulots.id)
wishlist11 = user4.wishlists.create!(experience_id: experience_cagette.id)
wishlist12 = user6.wishlists.create!(experience_id: experience_saigon.id)
wishlist13 = user7.wishlists.create!(experience_id: experience_library.id)
wishlist14 = user8.wishlists.create!(experience_id: experience_marmont.id)
wishlist15 = user9.wishlists.create!(experience_id: experience_providence.id)
wishlist16 = user9.wishlists.create!(experience_id: experience_vespa_tour.id)
wishlist17 = user10.wishlists.create!(experience_id: experience_robinson.id)
wishlist18 = user10.wishlists.create!(experience_id: experience_poney.id)
wishlist19 = user10.wishlists.create!(experience_id: experience_utopia.id)
wishlist20 = user10.wishlists.create!(experience_id: experience_massage.id)


puts "-- Roadmaps"

roadmap1 = userjulien.roadmaps.create!(start_destination: "Toulouse", end_destination: "Saint-Tropez")
roadmap2 = userjulien.roadmaps.create!(start_destination: "Boston", end_destination: "Brooklyn")
roadmap2.update_columns(
  start_date: Date.new(2016,1,10),
  end_date: Date.new(2016,1,13)
  )
roadmap3 = userjulien.roadmaps.create!(start_destination: "Bordeaux", end_destination: "Berlin")
roadmap5 = userjulien.roadmaps.create!
roadmap4 = userjulien.roadmaps.create!(start_destination: "Bordeaux", end_destination: "Bordeaux")

roadmap2.activities.create!(experience_id: experience_providence.id, planned_on: Date.new(2016,1,12))


puts "-- Done!"
puts "Seed done !"
