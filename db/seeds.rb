User.create!(account_id: "@taro_123", 
            username: "taro", 
            email: "taro@example.com", 
            password: "Password1", 
            password_confirmation: "Password1")

user = User.first
50.times do
  title = Faker::Lorem.sentence(word_count: 5)
  highlight = Faker::Lorem.sentence(word_count: 30)
  action = Faker::Lorem.sentence(word_count: 50)
  user.actionposts.create!(title: title, highlight: highlight, action: action)
end