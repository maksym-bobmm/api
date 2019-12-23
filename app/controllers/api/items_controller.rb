class Api::ItemsController < ApplicationController
  def create
    begin
      head 400 and return unless params['RequestNumber'] && params['SequenceNumber'] && params['RequestType'] &&
          params['DateTimes']['ResponseDueDateTime'] && params['ServiceArea']['PrimaryServiceAreaCode']['SACode'] &&
          params['ServiceArea']['AdditionalServiceAreaCodes']['SACode'] &&
          params['ExcavationInfo']['DigsiteInfo']['WellKnownText'] && params['Excavator']['CompanyName'] &&
          params['Excavator']['Address'] && params['Excavator']['CrewOnsite']
    rescue NoMethodError
      head 400 and return
    end
    ticket = Ticket.create!(ticket_params)
    ticket.create_excavator!(excavator_params)
    if ticket&.excavator
      head  201
    else
      head 401
    end
  end

  private

  def ticket_params
    filtered_params = params.permit(
        :RequestNumber, :SequenceNumber, :RequestType,
        DateTimes:  :ResponseDueDateTime,
        ServiceArea: {
            PrimaryServiceAreaCode: :SACode,
            AdditionalServiceAreaCodes: :SACode
        }
      )
    #filtered_params['ServiceArea'].merge(asd: params.dig(:ServiceArea, :AdditionalServiceAreaCodes, :SACode))
    filtered_params.merge(ExcavationInfo:{ WellKnownText: params.dig(:ExcavationInfo, :DigsiteInfo, :WellKnownText) })
  end

  def excavator_params
    params.permit(Excavator: [:CompanyName, :Address, :CrewOnsite])
  end
end
