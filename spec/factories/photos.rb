FactoryBot.define do
  factory :photo do
    association :event
    association :user
    photo { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/files/img.png'))) }
  end
end
