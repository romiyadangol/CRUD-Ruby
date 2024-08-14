class Organization < ApplicationRecord
    has_many :users
    has_many :members
    has_many :articles
    validates :name, presence: true, uniqueness: true
end
