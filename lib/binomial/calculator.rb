require 'binomial/integer'
module Binomial
  # Params:
  #   - trials:         Total number of trials conducted
  #   - probability:    The probability of one success
  #   - target:         The desired amount of successes
  class Calculator
    attr_accessor :trials, :probability, :target

    def initialize(params = {})
      @trials = params[:trials]
      @probability = params[:probability]
      @target = params[:target]

      check_positive(:@trials)
      check_positive(:@target)
      check_positive(:@probability)

      @probability <= 1  or raise "Error: probability[#{@probability}] must be <= 1"
      @trials >= @target or raise "Error: target[#{@target}] must be < trials[#{@trials}]"
    end

    # param: name of instance variable WITH leading @
    def check_positive(inst_var)
      value = instance_variable_get(inst_var)
      var_name = inst_var.to_s.delete('@')
      value > 0 or
        raise "Error: '#{var_name}' must be > 0, but was: #{value}"
    end

    def model
      "X~B(#{@trials}, #{@probability})"
    end

    # A representation of the equation performed
    def equation
      "P(X=#{@target}) = #{@trials}C#{@target} * #{@probability}^#{@target} *"
      + " #{1 - @probability}^#{@trials - @target} = #{calculate}"
    end

    # Calculates the result
    def calculate
      @trials.choose(@target) *
      (@probability ** @target) *
      ((1 - @probability) ** (@trials - @target))
    end
  end
end
