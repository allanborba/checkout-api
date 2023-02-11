class DiscontCoupon < ApplicationRecord

  def still_valid?
    Date.today <= expiration_date
  end
end
