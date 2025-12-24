

function y = clip_signal(x, L, od)
  y = x .* od.pregain;
  for i = 0:L-1
    abs_val = abs(y(i +1));
    sign_val = 1;
    if (y(i +1) < 0)
      sign_val = -1;
    end

    if (abs_val < od.threshold)
      y(i +1) = 2*y(i +1);
    elseif (abs_val < od.threshold * 2)
      y(i +1) = sign_val * (3 - (2-3*abs_val)^2) / 3;
    else
      y(i +1) = sign_val;
    end
  end
end

