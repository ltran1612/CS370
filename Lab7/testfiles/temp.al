int f(boolean a[], boolean b, int c)
begin
end

int main(void)
begin
int a[1];
int c;
f(a, false, f(a, true, 2) + 1);
end
int x;