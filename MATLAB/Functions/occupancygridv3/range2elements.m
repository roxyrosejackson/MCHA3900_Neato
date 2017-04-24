function elements = range2elements(range,spacing)
if (range>0)
    elements = ceil(range/spacing);
else
    elements = floor(range/spacing);
end
