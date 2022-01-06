# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company = Company.create(name: 'Testowa')

user1 = company.users.create(full_name: 'Tester testowy', email: 'test1@test.test', admin: true, password: 'password1234', password_confirmation: 'password1234')
user2 = company.users.create(full_name: 'Tester testowy2', email: 'test2@test.test', admin: false, password: 'password1234', password_confirmation: 'password1234')

