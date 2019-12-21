class Excavator < ApplicationRecord
  validates_presence_of :created_at, :updated_at

  belongs_to :ticket
end
