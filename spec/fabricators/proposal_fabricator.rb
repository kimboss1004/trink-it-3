Fabricator(:proposal) do
  location { ["Kogan Square","Boss Plaza","University Yard"].sample }
  date { Faker::Date.forward(23) }
  time '06:54'
  message { Faker::Lorem.paragraph }
end