int num[100], x;

void testDataType(void)
begin
    boolean t, f;

    write "TEST THE VALUE OF BOOLEAN VARIABLES";
    t = true;
    f = false;

    write "The value of true is: ";
    write t;

    write "The value of false is: ";
    write f; 
end

int fib(int x, int array[])
begin
    if (x < 0) then return 0;
    if (x == 0) or (x == 1) then return x;
    if (array[x]) then return array[x];

    write "NEW VALUE";
    array[x] = fib(x - 1, array) + fib(x - 2, array);
    return array[x];
end
int add(int x, int y)
begin
    return x + y;
end
void testFunction(void)
begin
    int mem[100], x;

    write "TEST FUNCTION, RECURSION, AND FUNCTION AS A PARAMETER OF ANOTHER FUNCTION";

    write "Test recursive with fibonanci number less than 100 with memorization of a local array";  
    write "Enter value for x: ";
    read x;
    write "The result is: ";
    write fib(x, mem);

    write "Test function as parameter of a function";
    write "Enter a value for x: ";
    read x;
    write "The result is: (expected to be x + 2)";
    write add(1, add(1, x));
end

void testSelection(void)
begin   
    int one, two;

    write "TEST IF, ELSE STATEMENT AND MULTIPLE IF ELSE IF";

    write "Enter a value for one: ";
    read one;
    write "Enter a value for two: ";
    read two;

    write "Checking these two conditions";
    if (one > two) then
        write "one is greater than two";
    else if (one == two) then
        write "one is equal to two";
    else if (one < two) then
        write "one is less than two";

    write "";
    write "Check equal,not equal";
    if (one == two) then
        write "one is equal to two";
    else 
        write "one is not equal to two";

    write "Test selection with one number only";
    write "Enter one";
    read one;
    if (one) then
        write "TRUE";
    else
        write "FALSE";
end

void testWhile(void)
begin
    int one, two, array[100];
    int count;

    write "TEST WHILE";

    count = 0;
    one = 1;
    two = 2;

    write "Assigning values to the array";
    while (count < 5) do
    begin
        array[count] = two + 1 + count;
        count = count + 1;
    end

    write "Write the values of one, two, array[] of five starting locations: ";
    write one;
    write two;
    count = 0;
    while (count < 5) do
    begin
        write array[count];
        count = count + 1;
    end

    count = 5;
    write "Write WHILE to the screen 5 times, with while (count)";
    while (count) do
    begin
        write "WHILE";
        count = count - 1;
    end
end

void testWriteReadAsignment(void)
begin
    int one, two, array[100];

    write "TEST WRITE READ ASSIGNMENT";

    write "Test writing a value 1";
    write 1;
    write "";
    
    write "Test variable (scalar and array) assignment";
    one = 1;
    array[0] = 10;
    write "The value of scalar one is: (expected 1)";
    write one;
    write "The value of array[0] is: (expected 10)";
    write array[0];
    write "";

    write "Test read the variable assignment: ";
    two = 1;
    write "The value of two before read is: ";
    write two;
    write "Enter a value for two: ";
    read two;
    write "The value of two after read is: ";
    write two;
    write "";
end

void changeVar(int x, int num[])
begin
    write "In change variable: ";
    x = 0-1;
    num[0] = 0-1;
end
void testVariablesLevel(void)
begin
    x = 1;
    num[0] = 1;

    write "TEST DETECTING GLOBAL, LOCAL VARIABLES, AND ARRAY PARAMETER";

    begin
        int x;
        int num[10];

        x = 2;
        write "local x is: (expected 2) ";
        write x;
        write "";

        num[0] = 2;
        write "local array num x[0] is: (expected 2) ";
        write num[0];
        write "";
    end

    write "global x is: (expected 1)";
    write x;
    write "";

    write "global array num[0] is: (expected 1) ";
    write num[0];
    write "";

    write "Passing global x, and global array num to a function to assign its value: ";
    changeVar(x, num);

    write "global x is: (expected 1)";
    write x;
    write "";

    write "global array num[0] is: (expected -1) ";
    write num[0];
    write "";
end

void testExpression(void) 
begin
    int x, y;

    write "TEST EXPRESSION (+, -, *, /, <,<=, >, >=, !=, ==, and, or, not)";

    write "Enter x: ";
    read x;
    write "Enter y: ";
    read y;
    write "";

    write "x + y is: ";
    write (x + y);
    write "";

    write "x - y is: ";
    write (x - y);
    write "";

    write "x * y is: ";
    write (x * y);
    write "";

    write "x / y is: ";
    write (x / y);
    write "";

    write "x < y is: ";
    write (x < y);
    write "";

    write "x <= y is: ";
    write (x <= y);
    write "";

    write "x > y is: ";
    write (x > y);
    write "";

    write "x >= y is: ";
    write (x >= y);
    write "";

    write "x ==  y is: ";
    write (x == y);
    write "";

    write "x != y is: ";
    write (x != y);
    write "";

    write "x and y is: ";
    write (x and y);
    write "";

    write "x or y is: ";
    write (x or y);
    write "";

    write "not(x) is: ";
    write not(x);
    write "";

    write "true, false, not(true), not(false) is: ";
    write true;
    write (false);
    write not(true);
    write not(false);

    write "Test x == 2 or/and 3 == 1";
    write "Enter x: ";
    read x;
    write "x == 2 or 3 == 1: (expected 1 if x = 3)";
    write x == 2 or 3 == 1;
    write "x == 2 and 3 == 1: (expected 1 if x = 2)";
    write x == 2 and 3 == 1;

end

void main(void)
begin
    int option;
    option = 0-1;
  
    while option do
    begin
        write "Choosing the options below for testing: (enter 0 to quit)";
        write "Option 1: TEST DETECTING GLOBAL, LOCAL VARIABLES, AND ARRAY PARAMETER";
        write "Option 2: TEST EXPRESSION (+, -, *, /, <,<=, >, >=, !=, ==, and, or, not)";
        write "Option 3: TEST WRITE READ ASSIGNMENT";
        write "Option 4: TEST WHILE";
        write "Option 5: TEST IF, ELSE STATEMENT AND MULTIPLE IF ELSE IF";
        write "Option 6: TEST FUNCTION, RECURSION, AND FUNCTION AS A PARAMETER OF ANOTHER FUNCTION";
        write "Option 7: TEST THE VALUE OF BOOLEAN VARIABLES";
        read option;

        if (option == 1) then testVariablesLevel();
        else if (option == 2) then testExpression();
        else if (option == 3) then testWriteReadAsignment();
        else if (option == 4) then testWhile();
        else if (option == 5) then testSelection();
        else if (option == 6) then testFunction();
        else if (option == 7) then testDataType();
    end
end