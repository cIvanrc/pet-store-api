# frozen_string_literal: true

puts 'Destroying all Pets'
Pet.destroy_all

puts 'Creating pets...'
1.upto(1_000) do |n|
  Pet.create(name: "pet_#{n}")
end
puts 'Pets created successfully'
