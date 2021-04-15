for i in 1..48
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  name = "#{first_name} #{last_name}"
  email = Faker::Internet.safe_email(name)

  user = User.new
  user.email = email
  user.first_name = first_name
  user.last_name = last_name
  user.street_address = Faker::Address.street_address
  user.city = Faker::Address.city
  user.province = Faker::Address.state
  user.postal_code = Faker::Address.postcode
  user.country = Faker::Address.country
  if user.save
    p "Saved user ##{i}: #{name} (#{email})"
    for ii in 1..48
      micropost = Micropost.new
      micropost.user = user
      micropost.message = Faker::Lorem.paragraph
      if micropost.save
        p "Micropost ##{ii} saved for #{name}"
      else
        p micropost.errors
      end
    end
  else
    p user.errors
  end
end

