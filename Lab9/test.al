
int f(int x, int y)
begin

int z;

z = x + y;

write z;

return z;

end

int g(int w)
begin

int bb;

bb = w + f(7,9);

return bb;

end

void main(void)
begin

int q;

q = f(f(2,5),g(5));

write q;

end
