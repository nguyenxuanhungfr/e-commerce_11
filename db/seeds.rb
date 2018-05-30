10.times do |n|
  name  = Faker::Name.name
  Category.create!(name:  name)
end
User.create!(name:  "Example User", email: "hungnx96@gmail.com",
  password: "123123", password_confirmation: "123123", role: 1)
User.create!(name:  "Example User", email: "hungnx06@gmail.com",
  password: "123123", password_confirmation: "123123", role: 2)
users = User.order(:created_at).take(3)
10.times do |n|
  name  = Faker::Lorem.sentence(2)
  phone = "093457876#{n+1}"
  users.each {|user| user.orders.create!(address:  name, phone: phone,
    created_at: Time.zone.now)}
end
