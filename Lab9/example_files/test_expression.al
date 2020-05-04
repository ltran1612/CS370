  int x,y,z,A[100];
  boolean n[12];

void main(void) begin
  read x;
  read y;

  write "x + y is: ";
  write (x + y);

  write "x - y is: ";
  write (x - y);

  write "x * y is: ";
  write (x * y);

  write "x / y is: ";
  write (x / y);

  write "x < y is: ";
  write (x < y);

  write "x <= y is: ";
  write (x <= y);

  write "x > y is: ";
  write (x > y);

  write "x >= y is: ";
  write (x >= y);

  write "x ==  y is: ";
  write (x == y);

  write "x != y is: ";
  write (x != y);

  write "x and y is: ";
  write (x and y);

  write "x or y is: ";
  write (x or y);

  write "true, false, not(true), not(false)";
  write true;
  write (false);
  write not(true);
  write not(false);
  write not(n);
end

int swap(int one, int two, int length, int array[])
begin
    int temp;
    if (one < 0) or (two < 0) then return 0-1;
    if (one < length) and (two < length) then
    begin
        temp = array[one];
        array[one] = array[two];
        array[two] = temp;
        return 1;
    end

    return 0-1;
end

void sort(int length, int array[])
begin
    int i;
    i = 0;
    while i < length - 1 do
    begin
        int j;
        j = 0;
        while j < length - i - 1 do
        begin
            if (array[j] > array[j + 1]) then
            begin
                write "Swap";
                if (swap(j, j+1, 10, array)) then write "Swap successful";
                else write "Swap unsuccessful";
            end
            else
                write "Not swap";
            
            j = j + 1;
        end

        i = i + 1;
    end
end