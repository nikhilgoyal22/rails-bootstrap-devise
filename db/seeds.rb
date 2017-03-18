# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.find_by(email: 'admin@test.com').nil?
  code  = SecretCode.create(code: 'foobar')
  User.create(first: 'admin', last: '', email: 'admin@test.com', role: 'admin', secret_code: code)
end