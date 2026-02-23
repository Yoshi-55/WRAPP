FactoryBot.define do
  factory :work_log do
    job { nil }
    user { nil }
    started_at { "2026-02-24 01:29:38" }
    ended_at { "2026-02-24 01:29:38" }
    duration_minutes { 1 }
    note { "MyText" }
    deleted_at { "2026-02-24 01:29:38" }
  end
end
