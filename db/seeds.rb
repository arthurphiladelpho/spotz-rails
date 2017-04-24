require 'random_data'

50.times do

	User.create!(
		email: Faker::Internet.unique.email,
		password: RandomData.random_word
	)

end

users = User.all

150.times do

	Wiki.create!(
		title: Faker::Pokemon.unique.name,
		body: RandomData.random_sentence
	)

end

wikis = Wiki.all

puts "Seeds finished."
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."