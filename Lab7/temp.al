int f(int a[], boolean b, int c)
begin
end

int main(void)
begin
int a[100];
f(a, true, f(a, false, 2));
end
int x;