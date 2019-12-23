class Excavator < ApplicationRecord
  alias_attribute(:Excavator, :excavator)
  validates_presence_of :excavator

  belongs_to :ticket
end
