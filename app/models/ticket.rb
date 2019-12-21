class Ticket < ApplicationRecord
  validates_presence_of :request_number, :request_type, :sequence_number, :created_at, :updated_at

  has_one :excavator
end
