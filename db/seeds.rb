# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)
              
99.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

admin_user = User.first

50.times do |n|
  task_name = "タスク#{n + 1}"
  detail = "タスク詳細#{n + 1}"
  admin_user.tasks.create!(name: task_name, detail: detail)
end
