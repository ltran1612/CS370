int found[10];
int x;
int fib(int x)
begin
  if x == 0 then return 0;
  if (x == 1) then return 1;
  if (found[x] != 0) then return found[x];
  write "HERE";
  found[x] = fib(x - 1) + fib(x - 2);
  return found[x];
end

void main(void)
begin
  int i;
  i = 0;
  while i < 10 do
  begin 
    found[i] = 0;
    i = i + 1;
  end

  found[0] = 0;
  found[1] = 1;

  write "Enter a number";
  read x;

  write "The result is";
  write fib(fib(x));

  write "X is";
  write x;

  write "The array is: ";
  i = 0;
  while i < 10 do 
  begin
    write found[i];
    i = i + 1;
  end
end
