

% Computes the convolution of two sequences directly.
% x: input sequence
% h: input sequence (ideally the shorter input)
% y: output convolution
function y = conv_direct(x, h)
  N = length(x) + length(h) - 1;
  y = zeros(1, N);

  for n = 0:N-1

    for m = 0:length(h)-1
      x_index = n-m;
      if (x_index >= 0 && x_index < length(x))
        y(n+1) = y(n+1) + h(m+1)*x(x_index + 1);
      end
    end

  end
end

