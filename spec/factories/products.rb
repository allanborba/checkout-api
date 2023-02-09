FactoryBot.define do
  factory :product do
    description { "MyString" }
    unit_price { 1.5 }
    width { 3.0 }
    height { 2.0 }
    depth { 1.0 }
    weight { 1.0 }
  end
end
