FactoryBot.define do
  factory :travel_tour do
    name { "Amazing Tour" }
    category { "Adventure" }
    duration { 5 }
    price { 499.99 }
    description { "An amazing tour description An amazing tour description An amazing tour description An amazing tour description" }
    featured { false }
    highlights { "Highlight 1\nHighlight 2" }
    includes { "Inclusion 1\nInclusion 2" }

    trait :with_image do
      after(:build) do |tour|
        tour.image.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/sample_image.jpg')),
          filename: 'sample_image.jpg',
          content_type: 'image/jpeg'
        )
      end
    end

    trait :with_gallery do
      after(:build) do |tour|
        tour.gallery_images.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/gallery1.jpg')),
          filename: 'gallery1.jpg',
          content_type: 'image/jpeg'
        )
        tour.gallery_images.attach(
          io: File.open(Rails.root.join('spec/fixtures/files/gallery2.jpg')),
          filename: 'gallery2.jpg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
end