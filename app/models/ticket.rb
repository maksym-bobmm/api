class Ticket < ApplicationRecord

  validates_presence_of :request_number, :request_type, :sequence_number
  alias_attribute(:RequestNumber, :request_number)
  alias_attribute(:RequestType, :request_type)
  alias_attribute(:SequenceNumber, :sequence_number)
  alias_attribute(:DateTimes, :date_times)
  alias_attribute(:ServiceArea, :service_area)
  alias_attribute(:ExcavationInfo, :digsite_info)
  #alias_attribute( accepts_nested_attributes_for(:ExcavationInfo, :DigsiteInfo), :digsite_info)
  has_one :excavator, dependent: :delete
end
