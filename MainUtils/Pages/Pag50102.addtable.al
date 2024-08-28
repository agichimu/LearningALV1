page 50102 "AddPage"
{
    ApplicationArea = All;
    PageType = Card;
    UsageCategory = Administration;
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
                    Image = RemoveLine;
                    trigger OnAction()
                    begin
                        divisiontotal := Mycode.divide(num1, num2);
                    end;
                }
            }

        }
        area(Promoted)
        {
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
            group(Category_Category4)
            {
                Caption = 'Functions', Comment = 'Generated from the PromotedActionCategories property index 3.';
            }
            group(Category_Category5)
            {
                Caption = 'Job', Comment = 'Generated from the PromotedActionCategories property index 4.';
            }
            group(Category_Category6)
            {
                Caption = 'Addition', Comment = 'Generated from the PromotedActionCategories property index 5.';

                actionref(Addition_Promoted; Addition)
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'Substraction', Comment = 'Generated from the PromotedActionCategories property index 6.';

                actionref(Substraction_Promoted; Substraction)
                {
                }
            }
            group(Category_Category8)
            {
                Caption = 'Division', Comment = 'Generated from the PromotedActionCategories property index 7.';

                actionref(Division_Promoted; Division)
                {
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
