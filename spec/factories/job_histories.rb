FactoryBot.define do
  factory :job_history do
    job { nil }
    action_type { "MyString" }
    note { "MyText" }
    deleted_at { "2026-02-24 01:39:02" }
  end
end
