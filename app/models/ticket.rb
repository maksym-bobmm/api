# frozen_string_literal: true

require 'concerns/subkeys_validator'
class Ticket < ApplicationRecord
  validates_presence_of :request_number, :request_type, :sequence_number, :date_times, :service_area, :digsite_info
  validates_with SubkeysValidator::Ticket
  alias_attribute(:RequestNumber, :request_number)
  alias_attribute(:RequestType, :request_type)
  alias_attribute(:SequenceNumber, :sequence_number)
  alias_attribute(:DateTimes, :date_times)
  alias_attribute(:ServiceArea, :service_area)
  alias_attribute(:ExcavationInfo, :digsite_info)

  has_one :excavator, dependent: :delete
  accepts_nested_attributes_for(:excavator, reject_if: :all_blank)
end
