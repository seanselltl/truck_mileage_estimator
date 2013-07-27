require 'spec_helper'

shared_examples "a Coordinated class" do

  it "should have origin coordinates" do
    subject.origin_latitude, subject.origin_longitude = 0, 1
    expect(subject.origin_coordinates).to eq [0, 1]
  end

  it "should have destination coordinates" do
    subject.destination_latitude, subject.destination_longitude = 0, 1
    expect(subject.destination_coordinates).to eq [0, 1]
  end

end