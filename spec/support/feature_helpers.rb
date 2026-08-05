module FeatureHelpers
  def fill_in_travel_tour_form(attributes = {})
    fill_in 'Name', with: attributes[:name] || 'Test Tour'
    select attributes[:category] || 'Adventure', from: 'Category'
    fill_in 'Duration (days)', with: attributes[:duration] || 5
    fill_in 'Price', with: attributes[:price] || 199.99
    fill_in 'Description', with: attributes[:description] || 'Test description'
    
    if attributes[:highlights]
      fill_in 'Tour Highlights (one per line)', with: attributes[:highlights]
    end
    
    if attributes[:includes]
      fill_in "What's Included (one per line)", with: attributes[:includes]
    end
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end