# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  { owner: 'rails', repository: 'rails' },
].each do|repository_set|
  repository = Repository.find_or_create_by(owner: repository_set[:owner], repository: repository_set[:repository])
  repository.save
end

