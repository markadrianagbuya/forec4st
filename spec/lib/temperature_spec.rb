require 'spec_helper'
require 'temperature'

RSpec.describe Temperature do
  describe '.fahrenheit_to_celsius' do
    it "converts from negative fahrenheit" do
      expect(Temperature.fahrenheit_to_celsius(-10)).to be_within(0.1).of(-23.3)
    end

    it "converts from zero fahrenheit" do
      expect(Temperature.fahrenheit_to_celsius(0)).to be_within(0.1).of(-17.8)
    end

    it "converts from to zero celsius" do
      expect(Temperature.fahrenheit_to_celsius(32)).to eq(0)
    end

    it "converts from to positive fahrenheit" do
      expect(Temperature.fahrenheit_to_celsius(80)).to be_within(0.1).of(26.7)
    end
  end
end
