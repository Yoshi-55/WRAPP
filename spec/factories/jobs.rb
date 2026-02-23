FactoryBot.define do
  factory :job do
    maker { nil }
    owner { nil }
    vehicle_name { "MyString" }
    vehicle_model { "MyString" }
    vehicle_number { "MyString" }
    job_serial { "MyString" }
    description { "MyText" }
    status { "MyString" }
    started_at { "2026-02-24 01:28:26" }
    completed_at { "2026-02-24 01:28:26" }
    deleted_at { "2026-02-24 01:28:26" }
  end
end
