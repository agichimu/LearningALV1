page 50102 "AddPage"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;
    PromotedActionCategories = 'New,Process,Report,Functions,Job,Addition,Substraction,Division';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Fields';
                field(num1; num1)
                {
                    ApplicationArea = Basic;
                    Caption = 'Number 1';
                    ShowMandatory = true;
                }
                field(num2; num2)
                {
                    ApplicationArea = Basic;
                    Caption = 'Number 2';
                    ShowMandatory = true;
                }
            }
            group(Results)
            {
                field(addtotal; additiontotal)
                {
                    ApplicationArea = Basic;
                    Caption = 'Addition Total';
                    Editable = false;
                }
                field(subtotal; substractiontotal)
                {
                    ApplicationArea = Basic;
                    Caption = 'substraction Total';
                    Editable = false;
                }
                field(divtotal; divisiontotal)
                {
                    ApplicationArea = Basic;
                    Caption = 'Division Total';
                    Editable = false;
                }
            }

        }
    }

    actions
    {
        area(navigation)
        {

            group(Add)
            {
                action(Addition)
                {
                    ApplicationArea = Basic;
                    Caption = 'Addition';
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    image = Add;

                    trigger OnAction()
                    begin
                        additiontotal := Mycode.add(num1, num2);
                    end;
                }
            }

            group(Minus)
            {
                action(Substraction)
                {
                    ApplicationArea = Basic;
                    Caption = 'Substraction';
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    image = ReleaseShipment;
                    trigger OnAction()
                    begin
                        substractiontotal := Mycode.substraction(num1, num2);
                    end;
                }
            }

            group(divide)
            {
                action(Division)
                {
                    ApplicationArea = Basic;
                    Caption = 'Division';
                    Promoted = true;
                    PromotedCategory = Category8;
                    Image = RemoveLine;
                    PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        divisiontotal := Mycode.divide(num1, num2);
                    end;
                }
            }

        }
    }


    var
        Mycode: Codeunit Userscodeunit;
        num1: Integer;
        num2: Integer;
        total: Integer;

        // mytotalsValues: Integer;
        substractiontotal: Integer;
        additiontotal: Integer;
        divisiontotal: Integer;
}
