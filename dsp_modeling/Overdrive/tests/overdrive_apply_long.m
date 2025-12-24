

function y = overdrive_apply_long(x, L, od)
  numOfChunks = ceil(length(x)/L);
  y = zeros(1, numOfChunks*L); % Create space for output

  % Go through every chunk in x
  % This is what would be done to each buffer in a real-time system
  for i = 0:numOfChunks-1
    lowerbound = i*L;
    upperbound = lowerbound + L-1;

    x_i = x(lowerbound +1 : upperbound +1);
    y(lowerbound +1:upperbound +1) = overdrive_apply(x_i, L, od);
  end
end