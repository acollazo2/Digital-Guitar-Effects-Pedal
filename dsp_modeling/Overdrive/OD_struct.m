

classdef OD_struct < handle
  properties
    antialiasing_filter
    pre_filter
    pregain
    threshold
    post_filter
  end
  
  methods
    function obj = OD_struct(pregain, threshold, antialiasing_filter, pre_filter, post_filter)
      obj.pregain = pregain;
      obj.threshold = threshold;
      obj.antialiasing_filter = antialiasing_filter;
      obj.pre_filter = pre_filter;
      obj.post_filter = post_filter;
    end
  end
end

