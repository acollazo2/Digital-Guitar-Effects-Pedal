
% IIR struct containing fields to store
% filter coefficients and past inputs/outputs.
classdef IIR_struct < handle
  properties
    b % coefficients for numerator of transfer function [b0, b1*z^-1, b2*bz^-2,...]
    a % coefficients for denominator of transfer function [a0, a1*z^-1, a2*z^-2,...]
    past_x % [x(-1), x(-2), ...]
    past_y % [y(-1), y(-2), ...]
  end
  
  methods
    function obj = IIR_struct(b, a)
      obj.b = b;
      obj.a = a;
      obj.past_x = zeros(1, length(b) - 1);
      obj.past_y = zeros(1, length(a) - 1);
    end
  end
end

