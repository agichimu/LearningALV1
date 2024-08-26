codeunit 50102 "Userscodeunit"
{
    // trigger OnRun()
    // begin
    //      num1 := 45;
    //     num2 := 50;
    //     add(num1, num2)
    // end;

    procedure add(num1: Integer; num2: Integer): Integer
    var
        tot: Integer;
    begin
        tot := num1 + num2;
        //Message('The sum of the two numbers is %3', num1, num2, tot);
        exit(tot); // Return the total value
    end;

    var
        num1: Integer;
        num2: Integer;
}
