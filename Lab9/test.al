int f(int i, int array[])
begin
  return array[0] + i;
end

void main(void)
begin
  int x, y, A[10], i;
  read x;
  read y;

  i = 10;
  A[0] = 1;
  write f(i, A);
end