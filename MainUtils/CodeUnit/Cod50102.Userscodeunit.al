codeunit 50102 "Userscodeunit"
{
    procedure add(num1: Integer; num2: Integer): Integer

    begin
        if num1 = 0 then
            Error('Number 1 must have a value.');

        if (num2 = 0) then
            Error('Number 2 must have a value');

        total := num1 + num2;

        Message('The sum of the two numbers is %1', total);

        exit(total);
    end;

    procedure divide(num1: Integer; num2: Integer): Integer

    begin
        if num1 = 0 then
            Error('Number 1 must have a value.');

        if (num2 = 0) then
            Error('Number 2 must have a value');

        total := num1 / num2;

        Message('The division of the two numbers is %1', total);

        exit(total);
    end;

    procedure substraction(num1: Integer; num2: Integer): Integer

    begin
        if num1 = 0 then
            Error('Number 1 must have a value.');

        if (num2 = 0) then
            Error('Number 2 must have a value');

        total := num1 - num2;

        Message('The subtraction of the two numbers is %1', total);

        exit(total);
    end;

    var
        num1: Integer;
        num2: Integer;
        total: Integer;
}
