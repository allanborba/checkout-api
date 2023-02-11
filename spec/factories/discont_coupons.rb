FactoryBot.define do
  factory :discont_coupon do
    expiration_date { Date.today }
    discont { 0.2 }
    name { "cupon" }
  end
end
