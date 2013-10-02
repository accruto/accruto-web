namespace 'accruto:addresses' do
  desc "Seed database with candidates"
  task :seed => :environment do
    10.times do
      street = Faker::Address.street_name
      city = Faker::Address.city
      state = Faker::Address.us_state
      postcode = Faker::Address.zip_code
      Address.create(
        street: street,
        city: city,
        state: state,
        postcode: postcode
      )
      puts "Adding Address - #{street}, #{city}, #{state} #{postcode}\n"
    end
  end
end