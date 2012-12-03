require 'spec_helper'
require 'binomial'

describe "Binomial::Calculator" do
  describe "calculate" do
    def binom_calc(trials,prob,target)
      Binomial::Calculator.new(
        :trials => trials,
        :probability => prob,
        :target => target
      )
    end

    it "should validate probability is > 0" do
      expect { binom_calc(10,0,3).calculate }.to raise_error
    end

    it "should validate probability is < 1" do
      expect { binom_calc(10,1.1,3).calculate }.to raise_error
    end

    it "should succeed if probability is >0 and <1" do
      expect { binom_calc(10, 0.2, 3).calculate }.to_not raise_error
    end

    it "should validate target < trials" do
      expect { binom_calc(10, 0.2, 11).calculate }.to raise_error
    end

    it "should succeed if target < trials" do
      expect { binom_calc(10, 0.2, 3).calculate }.to_not raise_error
    end

    it "should validate target > 0" do
      expect { binom_calc(10, 0.2, 0).calculate }.to raise_error
    end

    it "should succeed if target > 0" do
      expect { binom_calc(10, 0.2, 3).calculate }.to_not raise_error
    end

    it "should produce the correct results" do
      binom_calc(2,0.5,2).calculate.should == 0.25
      binom_calc(2,0.5,1).calculate.should == 0.5
    end
  end
end
