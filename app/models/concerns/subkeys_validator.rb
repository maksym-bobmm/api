# frozen_string_literal: true

module SubkeysValidator
  class Ticket < ActiveModel::Validator
    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    def validate(record)
      if record.attributes.dig('date_times', 'ResponseDueDateTime')
        if record.attributes['date_times']['ResponseDueDateTime'].blank?
          record.errors.add(:DateTimes, 'ResponseDueDateTime must be not empty')
        end
        unless record.attributes.dig('date_times', 'ResponseDueDateTime').instance_of?(String)
          record.errors.add(:DateTimes, 'ResponseDueDateTime must be a string')
        end
      else
        record.errors.add(:DateTimes, 'must have ResponseDueDateTime')
      end

      if record.attributes.dig('service_area', 'PrimaryServiceAreaCode', 'SACode')
        if record.attributes['service_area']['PrimaryServiceAreaCode']['SACode'].blank?
          record.errors.add(:service_area, 'PrimaryServiceAreaCode -> SACode must be not empty')
        end
        unless record.attributes.dig('service_area', 'PrimaryServiceAreaCode', 'SACode').instance_of?(String)
          record.errors.add(:ServiceArea, 'PrimaryServiceAreaCode -> SACode must be a string')
        end
      else
        record.errors.add(:ServiceArea, 'must have PrimaryServiceAreaCode -> SACode')
      end

      if record.attributes.dig('service_area', 'AdditionalServiceAreaCodes', 'SACode')
        if record.attributes['service_area']['AdditionalServiceAreaCodes']['SACode'].blank?
          record.errors.add(:service_area, 'AdditionalServiceAreaCodes -> SACode must be not empty')
        end
        unless record.attributes['service_area']['AdditionalServiceAreaCodes']['SACode'].instance_of?(Array)
          record.errors.add(:ServiceArea, 'AdditionalServiceAreaCodes -> AdditionalServiceAreaCodes -> SACode
                                           must be an array')
        end
      else
        record.errors.add(:ServiceArea, 'must have AdditionalServiceAreaCodes -> AdditionalServiceAreaCodes -> SACode')
      end

      if record.attributes.dig('digsite_info', 'WellKnownText')
        if record.attributes['digsite_info']['WellKnownText'].blank?
          record.errors.add(:digsite_info, 'WellKnownText must be not empty')
        end
        unless record.attributes.dig('digsite_info', 'WellKnownText').instance_of?(String)
          record.errors.add(:ExcavationInfo, 'DigsiteInfo -> WellKnownText must be a string')
        end
      else
        record.errors.add(:ExcavationInfo, 'must have DigsiteInfo -> WellKnownText')
      end

      unless record.request_number_before_type_cast.instance_of?(String)
        record.errors.add(:request_number, 'must be a string')
      end
      unless record.request_type_before_type_cast.instance_of?(String)
        record.errors.add(:request_type, 'must be a string')
      end
      unless record.sequence_number_before_type_cast.instance_of?(String)
        record.errors.add(:sequence_number, 'must be a string')
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
  end

  class Excavator < ActiveModel::Validator
    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
    def validate(record)
      if record.attributes.dig('excavator', 'CompanyName')
        if record.attributes.dig('excavator', 'CompanyName').blank?
          record.errors.add(:Excavator, 'excavator -> CompanyName must be not empty')
        end
        unless record.attributes.dig('excavator', 'CompanyName').instance_of?(String)
          record.errors.add(:Excavator, 'excavator -> CompanyName must be a string')
        end
      else
        record.errors.add(:Excavator, 'must have excavator -> CompanyName')
      end

      if record.attributes.dig('excavator', 'CrewOnsite')
        if record.attributes.dig('excavator', 'CrewOnsite').blank?
          record.errors.add(:Excavator, 'excavator -> CrewOnsite must be not empty')
        end
        unless record.attributes.dig('excavator', 'CrewOnsite').instance_of?(String)
          record.errors.add(:Excavator, 'excavator -> CrewOnsite must be a string')
        end
      else
        record.errors.add(:Excavator, 'must have excavator -> CrewOnsite')
      end

      if record.attributes.dig('excavator', 'Address', 'Address')
        if record.attributes.dig('excavator', 'Address', 'Address').blank?
          record.errors.add(:Excavator, 'Address -> Address must be not empty')
        end
        unless record.attributes.dig('excavator', 'Address', 'Address').instance_of?(String)
          record.errors.add(:Excavator, 'Address -> Address must be a string')
        end
      else
        record.errors.add(:Excavator, 'must have Address -> Address')
      end

      if record.attributes.dig('excavator', 'Address', 'City')
        if record.attributes.dig('excavator', 'Address', 'City').blank?
          record.errors.add(:Excavator, 'Address -> City must be not empty')
        end
        unless record.attributes.dig('excavator', 'Address', 'City').instance_of?(String)
          record.errors.add(:Excavator, 'Address -> City must be a string')
        end
      else
        record.errors.add(:Excavator, 'must have Address -> City')
      end

      if record.attributes.dig('excavator', 'Address', 'State')
        if record.attributes.dig('excavator', 'Address', 'State').blank?
          record.errors.add(:Excavator, 'Address -> State must be not empty')
        end
        unless record.attributes.dig('excavator', 'Address', 'State').instance_of?(String)
          record.errors.add(:Excavator, 'Address -> State must be a string')
        end
      else
        record.errors.add(:Excavator, 'must have Address -> State')
      end

      if record.attributes.dig('excavator', 'Address', 'Zip')
        if record.attributes.dig('excavator', 'Address', 'Zip').blank?
          record.errors.add(:Excavator, 'Address -> Zip must be not empty')
        end
        unless record.attributes.dig('excavator', 'Address', 'Zip').instance_of?(String)
          record.errors.add(:Excavator, 'Address -> Zip must be a string')
        end
      else
        record.errors.add(:Excavator, 'must have Address -> Zip')
      end

      unless record.excavator_before_type_cast.instance_of?(String)
        record.errors.add(:excavator, 'must be a string')
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
  end
end
