Fabricator(:book) do 
  price { Faker::Number.number(3) }
  title { ["Biology","Physics","Chemistry","Statistics"].sample }
  description { Faker::Lorem.paragraph }
  condition { ["Good","Bad","Okay"].sample }
  swap { ["Biology","Physics","Chemistry","Statistics"].sample }
end 