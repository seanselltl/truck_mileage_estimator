require 'spec_helper'

describe Actual do

  it_behaves_like "a Coordinated class"
  it { should have_attribute :origin_latitude }
  it { should ensure_inclusion_of(:origin_latitude).in_range(-90..90) }
  it { should have_attribute :destination_latitude }
  it { should ensure_inclusion_of(:destination_latitude).in_range(-90..90) }

  it { should have_attribute :origin_longitude }
  it { should ensure_inclusion_of(:origin_longitude).in_range(-180..180) }
  it { should have_attribute :destination_longitude }
  it { should ensure_inclusion_of(:destination_longitude).in_range(-180..180) }

  it { should have_attribute :miles }
  it { should validate_numericality_of(:miles).is_greater_than_or_equal_to(0) }

  it { should have_attribute :direct_miles }
  it { should validate_numericality_of(:direct_miles).is_greater_than_or_equal_to(0) }

  context "when finding similar known distances" do
    before do
      @more_similar = FactoryGirl.create(:actual, origin_latitude: 1, origin_longitude: 1, destination_latitude: 10, destination_longitude: 10, miles: 100)
      @less_similar = FactoryGirl.create(:actual, origin_latitude: 10, origin_longitude: 10, destination_latitude: 10, destination_longitude: 10, miles: 200)
    end
    
    it "they should be in the right order" do
      expect(described_class.like([0,0],[10,10]).first).to eq @more_similar
    end
  end

end
