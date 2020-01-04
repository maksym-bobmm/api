# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all.includes(:excavator)
  end

  # rubocop:disable Style/AndOr
  def show
    head 422 and return unless params['id']

    @ticket = Ticket.includes(:excavator).find(params['id'])
    geojson = make_geojson(@ticket.digsite_info['WellKnownText'])
    gon.geojson = geojson
  end
  # rubocop:enable Style/AndOr

  private

  def make_geojson(ticket)
    geojson = receive_json_template
    coordinates = parse_coordinates(ticket)
    coordinates.each do |coordinate|
      geojson[:source][:data][:features] << {
                                              type: 'Feature',
                                              geometry: {
                                                type: 'Point',
                                                coordinates: coordinate
                                              }
                                            }
    end
    geojson
  end

  def parse_coordinates(ticket)
    str = ticket.delete!(')' + 'POLYGON((')
    str.split(',').map { |element| element.split(' ').map(&:to_d) }
  end

  def receive_json_template
    {
      id: 'points',
      type: 'symbol',
      source: {
        type: 'geojson',
        data: {
          type: 'FeatureCollection',
          features: []
        }
      },
      layout: {
          'icon-image': 'exc',
          'icon-size': 0.09,
      },
      paint: {
        'fill-color': '#369',
        'fill-opacity': 0.8
      }
    }
  end
end
