class Site < ApplicationRecord
  validates_presence_of :name, :address, :tel
  belongs_to :user
  has_many :pictures, :dependent => :destroy
end
