
% FIR struct containing fields to store
% the impulse response and past inputs.
classdef FIR_struct < handle
  properties
    h % Impulse response
    M % length of impulse response
    past_x % [x(-1), x(-2), ...], size M-1
  end
  
  methods
    function obj = FIR_struct(h)
      obj.h = h;
      obj.M = length(h);
      obj.past_x = zeros(1, obj.M-1);
    end
  end
end

