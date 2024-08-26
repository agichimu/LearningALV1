page 50102 "AddPage"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                field(num1; num1)
                {
                    ApplicationArea = All;
                    Caption = 'Number 1';
                }
                field(num2; num2)
                {
                    ApplicationArea = All;
                    Caption = 'Number 2';
                }
                field(tot; mytotalsValues)
                {
                    ApplicationArea = All;
                    Caption = 'Total';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Addition)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    mytotalsValues := Mycode.add(num1, num2);
                    Message('success');
                end;
            }
        }
    }

    var
        Mycode: Codeunit Userscodeunit;
        num1: Integer;
        num2: Integer;
        mytotalsValues: Integer;
}
