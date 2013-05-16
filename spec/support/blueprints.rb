require 'machinist/active_record'

Article.blueprint do
  title {Faker::Lorem.word(3).join(" ")}
  body { Faker::Lorem.words(100).join(" ")}

end

User.blueprint do
	email {Faker::Internet.email}
	password { 'password'}
	password_confirmation {'password'}
end

Track.blueprint do
  # Attributes here
end
