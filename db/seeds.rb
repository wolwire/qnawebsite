# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Example User",
             email: "agrawal.mayank1996@gmail.com",
             password: "123123",
             password_confirmation: "123123",
             admin: true,activated: true,
             activated_at: Time.zone.now)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
10.times do
  content = Faker::Lorem.sentence(word_count: 50)
  ques = Faker::Lorem.questions(number: 1)
  users.each { |user| user.questions.create!(header: ques,content: content)}
end

questions = Question.order(:created_at).take(10)

10.times do
  content = Faker::Lorem.sentence(word_count: 50)
  questions.each { |ques| ques.answers.create!(content: content, user: ques.user)}
end
answers = Answer.order(:created_at).take(10)

10.times do
  content = Faker::Lorem.sentence(word_count: 5)
  answers.each { |ans| ans.comments.create!(content: content, user: ans.user)}
end

10.times do |n|
  content = "python#{n}"
  Tag.create(name: content)
end


tags = Tag.order(:created_at).take(10)

tags.each do |tag|
  questions=Question.order(:created_at).take(10)
  tag.questions<<questions
end
questions.each do |question|
  users.each do |user|
    question.vote.create(user_id: user.id, vote:true)
  end
  question.update(votes_rep:question.vote.where("vote is true").count-question.vote.where("vote is false").count)
end
users.each do |user|
  s=0
  user.questions.each do |question|
    s += question.votes_rep
  end
  user.answers.each do |answer|
    s += answer.votes_rep
  end
  user.update(reputation: s)
end

