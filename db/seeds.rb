# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
Product.create(title: 'Soft Kitty',
	description: %{<p>Soft kitty, Warm kitty, Little ball of fur. Happy kitty, Sleepy kitty, Purr, purr, purr.</p>},
	image_url: 'soft_kitty.jpg',
	price: 150.00)
Product.create(title: 'Sleepy Angel',
	description: %{<p>I am sleepy ange... Z-z-z, z-z-z.</p>},
	image_url: 'sleepy_angel.jpg',
	price: 160.00)
Product.create(title: 'Famous Giraffe',
	description: %{<p>This is a very famous giraffe Garold.</p>},
	image_url: 'famous_giraffe.jpg',
	price: 170.00)

User.create(name: 'admin',
  password: 'admin',
  password_confirmation: 'admin')
