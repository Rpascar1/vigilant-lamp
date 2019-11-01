# User.create(
#   username: "Corinna_Red",
#   email: "CR5551029@gmail.com",
#   password: "passwordy1"
# )
#
# 3.times do |index|
#   Joke.create(
#     name: "knock knock" "#{index}",
#     body: "Guess who, Yo Momma",
#     status: "working on it",
#     user_id: 1
#   )
# end


5.times do
  User.create(username: Faker::Internet.username, email: Faker::Internet.email, password: "passwordy1")
end
