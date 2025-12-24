
% Applies IIR filter to input block.
%   Saves necessary past inputs/outputs necessary for next block.
% x: input block of size L
% L: size of block
% iir: IIR_struct containing necessary IIR parameters
function y = IIR_filter_apply(x, L, iir)
  
  y = zeros(1, L);

  for i = 0:L-1
    % Go through x coefficients
    for j = 0:length(iir.b)-1
      index = i - j;
      if (index < 0)
        y(i +1) = y(i +1) + iir.b(j +1)*iir.past_x(-index-1 +1);
      else
        y(i +1) = y(i +1) + iir.b(j +1)*x(index +1);
      end
    end
    % Go through y coefficients
    for j = 1:length(iir.a)-1
      index = i - j;
      if (index < 0)
        y(i +1) = y(i +1) - iir.a(j +1)*iir.past_y(-index-1 +1);
      else
        y(i +1) = y(i +1) - iir.a(j +1)*y(index +1);
      end
    end
  end

  % Update past_x
  j = L-1;
  for i = 0:length(iir.past_x)-1
    iir.past_x(i +1) = x(j +1);
    j = j-1;
  end
  % Update past_y
  j = L-1;
  for i = 0:length(iir.past_y)-1
    iir.past_y(i +1) = y(j +1);
    j = j-1;
  end
  
end
