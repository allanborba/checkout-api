FactoryBot.define do
  factory :discont_coupon do
    still_valid { true }
    discont { 0.2 }
    name { "cupon" }
  end
end
