FactoryBot.define do
  factory :excavator do
    ticket
    excavator do
      { CompanyName: 'John Doe CONSTRUCTION',
        CrewOnsite: 'true',
        Address: {
            Address: '555 Some RD',
            City: 'SOME PARK',
            State: 'ZZ',
            Zip: '55555'
        } }
    end

    factory :excavator_without_company_name do
      excavator do
        { CompanyName: nil }
      end
    end
    factory :excavator_without_crew_on_site do
      excavator do
        { CrewOnsite: nil }
      end
    end
    factory :excavator_without_address do
      excavator do
        { Address: {
            Address: nil
        } }
      end
    end
    factory :excavator_without_city do
      excavator do
        { Address: {
            City: nil
        } }
      end
    end
    factory :excavator_without_state do
      excavator do
        { Address: {
            State: nil
        } }
      end
    end
    factory :excavator_without_zip do
      excavator do
        { Address: {
            Zip: nil
        } }
      end
    end
  end
end
