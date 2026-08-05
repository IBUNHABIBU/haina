require 'rails_helper'

RSpec.describe 'Travel Tours Form', type: :feature do
  let(:user) { create(:user) } # Assuming you have authentication
  let(:travel_tour) { build(:travel_tour) }
  let(:existing_tour) { create(:travel_tour, :with_image, :with_gallery) }

  before do
    login_as(user, scope: :user) # If authentication is required
    visit new_travel_tour_path # or edit_travel_tour_path(existing_tour)
  end

  describe 'form rendering' do
    it 'displays all form fields' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Category')
      expect(page).to have_field('Duration (days)')
      expect(page).to have_field('Price')
      expect(page).to have_field('Featured Tour')
      expect(page).to have_field('Description')
      expect(page).to have_field('Tour Highlights (one per line)')
      expect(page).to have_field("What's Included (one per line)")
      expect(page).to have_field('Main Tour Image')
      expect(page).to have_field('Gallery Images')
      expect(page).to have_button('Create Travel tour')
      expect(page).to have_link('Cancel')
    end

    it 'applies correct CSS classes' do
      expect(page).to have_css('form.space-y-6')
      expect(page).to have_css('input[name="travel_tour[name]"]')
      expect(page).to have_css('select[name="travel_tour[category]"]')
    end
  end

  describe 'creating a new tour' do
    context 'with valid attributes' do
      it 'creates a new tour' do
        fill_in 'Name', with: 'Amazon Adventure'
        select 'Adventure', from: 'Category'
        fill_in 'Duration (days)', with: 7
        fill_in 'Price', with: 999.99
        fill_in 'Description', with: 'An amazing adventure tour An amazing adventure tour through the Amazon rainforest with expert guides, wildlife spotting, and unforgettable cultural experiences.'
        fill_in 'Tour Highlights (one per line)', with: "Jungle trekking\nWildlife spotting"
        fill_in "What's Included (one per line)", with: "Accommodation\nMeals"

        expect do
          click_button 'Create Travel tour'
        end.to change(TravelTour, :count).by(1)

        expect(page).to have_content('Travel tour was successfully created.')
        expect(TravelTour.last.name).to eq('Amazon Adventure')
      end
    end

    context 'with invalid attributes' do
      it 'displays error messages' do
        fill_in 'Name', with: ''
        click_button 'Create Travel tour'

        expect(page).to have_css('#error_explanation')
        expect(page).to have_content('prohibited this tour from being saved')

        expect(page).to have_content("Name can't be blank")
      end

      it 'maintains filled form values after error' do
        fill_in 'Name', with: '' # Invalid
        fill_in 'Description', with: 'Test description' # Valid
        click_button 'Create Travel tour'

        expect(page).to have_field('Description', with: 'Test description')
      end
    end
  end

  # describe 'editing an existing tour' do
  #   before do
  #     visit edit_travel_tour_path(existing_tour)
  #   end

  #   it 'pre-fills form with existing values' do
  #     expect(page).to have_field('Name', with: existing_tour.name)
  #     expect(page).to have_field('Category', with: existing_tour.category)
  #     expect(page).to have_field('Duration (days)', with: existing_tour.duration)
  #   end

  #   it 'shows current image if attached' do
  #     expect(page).to have_content('Current Image')
  #     expect(page).to have_css('img[src*="image"]')
  #   end

  #   it 'shows remove image checkbox' do
  #     expect(page).to have_field('Remove current image')
  #   end

  #   it 'shows current gallery images' do
  #     expect(page).to have_content('Current Gallery Images')
  #     expect(page).to have_css('.grid-cols-3 img')
  #   end
  # end

  describe 'file uploads' do
    it 'allows main image upload' do
      attach_file('Main Tour Image', Rails.root.join('spec/fixtures/files/transport.jpg'))
      
      travel_tour = TravelTour.last
      expect(travel_tour.image).to be_attached
    end

    it 'allows multiple gallery image uploads' do
      attach_file('Gallery Images', [
        Rails.root.join('spec/fixtures/files/ndege.jpg'),
        Rails.root.join('spec/fixtures/files/nyati.jpg')
      ])

      # You might need custom JavaScript handling for multiple file display
    end
  end

  describe 'checkbox functionality' do
    it 'toggles featured checkbox' do
      checkbox = find_field('Featured Tour')
      expect(checkbox).not_to be_checked

      check 'Featured Tour'
      expect(checkbox).to be_checked

      uncheck 'Featured Tour'
      expect(checkbox).not_to be_checked
    end
  end

  describe 'navigation' do
    it 'cancels and returns to index page' do
      click_link 'Cancel'
      expect(current_path).to eq(travel_tours_path)
    end
  end

  describe 'price field formatting' do
    it 'displays dollar sign prefix' do
      price_field = find_field('Price')
      expect(page).to have_css('.absolute.inset-y-0.left-0', text: '$')
    end

    it 'accepts decimal values' do
      fill_in 'Price', with: '299.99'
      click_button 'Create Travel tour'
      
      # Add expectation based on your application behavior
    end
  end

  describe 'text areas' do
    it 'handles multi-line input for highlights' do
      highlights = "First highlight\nSecond highlight\nThird highlight"
      fill_in 'Tour Highlights (one per line)', with: highlights

      # Verify the value is maintained if form submission fails
      click_button 'Create Travel tour'

      field_value = find_field('Tour Highlights (one per line)').value
      # Normalize line endings to \n
      expect(field_value.gsub(/\r\n?/, "\n")).to eq(highlights)
    end
  end

end