FactoryBot.define do
  factory :job_photo do
    job { nil }
    image_url { "MyString" }
    photo_type { "MyString" }
    note { "MyText" }
    sort_order { 1 }
    deleted_at { "2026-02-24 01:33:25" }
  end
end
