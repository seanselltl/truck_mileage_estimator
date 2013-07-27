require 'spec_helper'

describe Estimate do
  it { should have_attribute(:origin_latitude) }
  it { should have_attribute(:origin_longitude) }
  it { should have_attribute(:destination_latitude) }
  it { should have_attribute(:destination_longitude) }

  it { should have_attribute :origin_longitude }
  it { should ensure_inclusion_of(:origin_longitude).in_range(-180..180) }
  it { should have_attribute :destination_longitude }
  it { should ensure_inclusion_of(:destination_longitude).in_range(-180..180) }

  it { should have_attribute :miles }
  it { should validate_numericality_of(:miles).is_greater_than_or_equal_to(0) }

  it_behaves_like "a Coordinated class"

  context "when estimating miles" do
    let(:actual) { FactoryGirl.build(:actual, miles: 500) }
    before do
      Geocoder::Calculations.stub(:distance_between) { 10 }
      Actual.stub(:like) { [actual] }
    end
    it "can estimate stem miles given known coordinates" do
      expect(subject.stem_miles(actual)).to eq 25
    end

    it "can estimate miles" do
      subject.calculate_miles
      expect(subject.miles).to eq 525
    end

  end

end
