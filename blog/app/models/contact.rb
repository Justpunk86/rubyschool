class Contact < ApplicationRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :message, presence: true
end
