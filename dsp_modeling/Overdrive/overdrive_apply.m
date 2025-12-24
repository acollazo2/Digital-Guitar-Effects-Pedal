


function y = overdrive_apply(x, L, od)
  y_1 = FIR_filter_apply(x, L, od.antialiasing_filter);
  y_2 = IIR_filter_apply(y_1, L, od.pre_filter);
  y_2 = clip_signal(y_2, L, od);
  y = IIR_filter_apply(y_2, L, od.post_filter);
end