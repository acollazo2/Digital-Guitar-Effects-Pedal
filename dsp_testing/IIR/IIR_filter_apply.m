

% x: long input sequence, length multiple of L
% L: input chunk size
% x_coeff: 

function y = IIR_filter_apply(x, L, x_coeff, y_coeff)
  
  % Ring buffers to hold past inputs and outputs (would be part of struct
  % in C implementation)

  % Go through every chunk in x
  % This is what would be done to each buffer in a real-time system
  
end

