function out = com2cos(in)

   global param
   parameters;
   comx = in.range*cos(in.theta) - param.rsb(1);
   comy = in.range*sin(in.theta) - param.rsb(2);
  
   out.theta = atan2(comy, comx); 
   out.range = sqrt(comx.^2 + comy.^2);

end