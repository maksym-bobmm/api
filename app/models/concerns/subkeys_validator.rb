# frozen_string_literal: true

module SubkeysValidator
  class Ticket < ActiveModel::Validator
    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    def validate(record)
      unless record.attributes.dig('date_times', 'ResponseDueDateTime')
        record.errors.add(:DateTimes, 'must have ResponseDueDateTime -> ResponseDueDateTime')
      end
      unless record.attributes.dig('service_area', 'PrimaryServiceAreaCode', 'SACode')
        record.errors.add(:ServiceArea, 'must have PrimaryServiceAreaCode -> SACode')
      end
      unless record.attributes.dig('service_area', 'AdditionalServiceAreaCodes', 'SACode')
        record.errors.add(:ServiceArea, 'must have AdditionalServiceAreaCodes -> AdditionalServiceAreaCodes -> SACode')
      end
      unless record.attributes.dig('digsite_info', 'WellKnownText')
        record.errors.add(:ExcavationInfo, 'must have DigsiteInfo -> WellKnownText')
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
  end

  class Excavator < ActiveModel::Validator
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def validate(record)
      unless record.attributes.dig('excavator', 'CompanyName')
        record.errors.add(:Excavator, 'must have excavator -> CompanyName')
      end
      unless record.attributes.dig('excavator', 'CrewOnsite')
        record.errors.add(:Excavator, 'must have excavator -> CrewOnsite')
      end
      unless record.attributes.dig('excavator', 'Address', 'Address')
        record.errors.add(:Excavator, 'must have Address -> Address')
      end
      unless record.attributes.dig('excavator', 'Address', 'City')
        record.errors.add(:Excavator, 'must have Address -> City')
      end
      unless record.attributes.dig('excavator', 'Address', 'Address')
        record.errors.add(:Excavator, 'must have Address -> State')
      end
      unless record.attributes.dig('excavator', 'Address', 'Zip')
        record.errors.add(:Excavator, 'must have Address -> Zip')
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
end
