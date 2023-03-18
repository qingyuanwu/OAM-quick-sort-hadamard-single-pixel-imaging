function [fd] = Fd(x,y,d)
if d == 0
    fd = x*y;
else
    fd = (x^d+y^d)^(1/d);
end
end