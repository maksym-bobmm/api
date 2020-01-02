# frozen_string_literal: true

require 'concerns/subkeys_validator'
class Ticket < ApplicationRecord
  validates_presence_of :request_number, :request_type, :sequence_number, :date_times, :service_area, :digsite_info
  validates :request_number, format: { with: /\d{8}-\d{5}/ }
  validates :sequence_number, format: { with: /\d{4}/ }
  validates_with SubkeysValidator::Ticket
  alias_attribute(:RequestNumber, :request_number)
  alias_attribute(:RequestType, :request_type)
  alias_attribute(:SequenceNumber, :sequence_number)
  alias_attribute(:DateTimes, :date_times)
  alias_attribute(:ServiceArea, :service_area)

  has_one :excavator, dependent: :delete
  accepts_nested_attributes_for(:excavator, reject_if: :all_blank)
end
