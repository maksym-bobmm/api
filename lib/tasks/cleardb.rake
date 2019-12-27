# frozen_string_literal: true

task cleardb: :environment do
  Ticket.destroy_all
end
