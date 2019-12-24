task cleardb: :environment do
  Ticket.destroy_all
end