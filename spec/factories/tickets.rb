FactoryBot.define do
  factory :ticket do
    request_number { '09252012-00001' }
    sequence_number { '2421' }
    request_type { 'Normal' }
    date_times { { ResponseDueDateTime: '2011/07/13 23:59:59' } }
    service_area do
      { PrimaryServiceAreaCode: { SACode: 'ZZGL103' },
        AdditionalServiceAreaCodes: { SACode: %w[ZZL01 ZZL02 ZZL03] } }
    end
    digsite_info do
      { WellKnownText: 'POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,
                        -81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,
                        -81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,
                        -81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,
                        -81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,
                        -81.13390268058475 32.07206917625161))' }
    end
    created_at { Time.now }
    updated_at { Time.now }

    factory :ticket_without_response_due_date_time do
      date_times { {} }
    end
    factory :ticket_without_primary_sacode do
      service_area do
        { AdditionalServiceAreaCodes: { SACode: %w[ZZL01 ZZL02 ZZL03] } }
      end
    end
    factory :ticket_without_additional_sacode do
      service_area do
        { PrimaryServiceAreaCode: { SACode: 'ZZGL103' } }
      end
    end
    factory :ticket_without_well_known_text do
      digsite_info do
        { WellKnownText: nil }
      end
    end
  end
end
