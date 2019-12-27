# frozen_string_literal: true

# api that creates ticket and excavator from request
class Api::ItemsController < ApplicationController
  # rubocop:disable Style/AndOr
  def create
    head 422 and return unless check_params

    ticket = Ticket.new(ticket_params.merge(excavator_attributes: excavator_params))

    if ticket.save
      head 201
    else
      head 422
    end
  end
  # rubocop:enable Style/AndOr

  private

  def ticket_params
    permitted_params = params.permit(
      :RequestNumber, :SequenceNumber, :RequestType,
      DateTimes: :ResponseDueDateTime,
      ServiceArea: [
        PrimaryServiceAreaCode: [:SACode],
        AdditionalServiceAreaCodes: [SACode: []]
      ]
    )
    permitted_params.merge(digsite_info: { WellKnownText: params.dig(:ExcavationInfo, :DigsiteInfo, :WellKnownText) })
  end

  def excavator_params
    permitted_params = params.permit(
      Excavator: %i[CompanyName CrewOnsite]
    )
    permitted_params['Excavator'][:Address] = {
      Address: params['Excavator']['Address'],
      City: params['Excavator']['City'],
      State: params['Excavator']['State'],
      Zip: params['Excavator']['Zip']
    }
    permitted_params
  end

  # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
  def check_params
    begin
      return false unless params['RequestNumber'] && params['SequenceNumber'] && params['RequestType'] &&
                          params['DateTimes']['ResponseDueDateTime'] && params['Excavator']['CompanyName'] &&
                          params['ServiceArea']['PrimaryServiceAreaCode']['SACode'] &&
                          params['ServiceArea']['AdditionalServiceAreaCodes']['SACode'] &&
                          params['ExcavationInfo']['DigsiteInfo']['WellKnownText'] &&
                          params['Excavator']['Address'] && params['Excavator']['CrewOnsite']
    rescue NoMethodError
      return false
    end
    true
  end
  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength
end
