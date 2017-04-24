function num = csv2double(str, delim, idx)

    C = strsplit(str, delim);
    if(length(C)<=1)
        num = NaN;
        return;
    end
    numstr = C{idx};
    num = str2double(numstr);

end