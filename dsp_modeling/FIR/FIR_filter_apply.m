
% Applies convolution to a block of input. Uses the overlap
%   add method so next block produces the correct output.
% x: input of size L
% L: size of input
% fir: FIR_struct instance containing necessary FIR parameters.
% y: output convolution, also size L
function y = FIR_filter_apply(x, L, fir)
  M = fir.M;
  
  % Perform convolution to produce first L terms
  y = conv_direct_range(x, L, fir.h, M, 0, L-1); % length L

  % Add saved samples to beginning of y_l
  for i = 0:M-1 -1
    y(i +1) = y(i +1) + fir.past_x(i +1);
  end

  % Compute remaining M-1 terms which are saved for next block
  fir.past_x = conv_direct_range(x, L, fir.h, M, L, L+M-1-1);
end
