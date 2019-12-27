# frozen_string_literal: true

require 'concerns/subkeys_validator'
class Excavator < ApplicationRecord
  alias_attribute(:Excavator, :excavator)
  validates_presence_of :excavator
  validates_with SubkeysValidator::Excavator

  belongs_to :ticket
end
