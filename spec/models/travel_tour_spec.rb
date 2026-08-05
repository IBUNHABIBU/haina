require 'rails_helper'

RSpec.describe TravelTour, type: :model do
  subject { build(:travel_tour) } 
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:duration).is_greater_than(0) }
    it { should validate_numericality_of(:price).is_greater_than(0) }
    
    it 'validates category inclusion' do
      expect(subject).to validate_inclusion_of(:category)
        .in_array(TravelTour::CATEGORIES)
    end
  end

  describe 'file attachments' do
    it { should have_one_attached(:image) }
    it { should have_many_attached(:gallery_images) }
  end
end