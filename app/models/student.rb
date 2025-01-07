class Student < ApplicationRecord
  validates :registration, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

end
