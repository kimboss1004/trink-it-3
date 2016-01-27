Fabricator(:user) do 
  email_address { Faker::Internet.email }
  password "password"
  name { Faker::Name.name }
end