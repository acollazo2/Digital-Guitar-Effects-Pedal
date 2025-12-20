

% x: long input sequence, length multiple of L
% L: input chunk size
% x_coeff: 

function y = IIR_filter_apply(x, L, x_coeff, y_coeff)

  % Go through every chunk in x
  % This is what would be done to each buffer in a real-time system
  end



function y = IIR_filter_apply_chunck(x, L, x_coeff, y_coeff)
  
  % Buffers to hold past inputs and outputs (would be ring buffers
  % and part of struct in the C implementation)
  persistent past_x;
  if (isempty(past_x))
    past_x = zeros(1, length(x_coeff) - 1);
  end
  persistent past_y;
  if (isempty(past_y))
    past_y = zeros(1, length(y_coeff));
  end
  
  y = zeros(1, L);

  for i = 0:L-1

  end


  
end

