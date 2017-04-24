function out = cos2com(in)

   global param
   parameters;
   sensx = in.range.*cos(in.theta) + param.rsb(1);
   sensy = in.range.*sin(in.theta) + param.rsb(2);
  
   out.theta = atan2(sensy, sensx); 
   out.range = sqrt(sensx.^2 + sensy.^2);

end