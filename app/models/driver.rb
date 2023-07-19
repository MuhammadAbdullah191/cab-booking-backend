class Driver < User
  validates :cnic, presence: true, length: { maximum: 20 }
  validates :license_number, presence: true, length: { maximum: 20 }
  validates :license_expiry, presence: true
end
