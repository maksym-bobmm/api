# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @tickets = Ticket.all.includes(:excavator)
  end

  # rubocop:disable Style/AndOr
  def show
    head 422 and return unless params['id']

    @ticket = Ticket.includes(:excavator).find(params['id'])
  end
  # rubocop:enable Style/AndOr
end
