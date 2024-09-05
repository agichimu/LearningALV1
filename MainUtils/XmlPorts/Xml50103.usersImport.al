namespace LearningAl.LearningAl;

xmlport 50103 usersImport
{
    Caption = 'usersImport';
    Format = VariableText;
    Direction = Import;
    // TextEncoding = UTF8;
    //TableSeparator = '';//New line
    schema
    {
        textelement(Root)
        {
            tableelement(users; users)
            {
                XmlName = 'Item';
                fieldelement(firstName; users.firstName)
                {
                }
                fieldelement(secondName; users.secondName)
                {
                }
                fieldelement(surname; users.surname)
                {
                }
                fieldelement(Phone_No; users.Phone_No)
                {
                }
                fieldelement(emailID; users.emailID)
                {
                }
                fieldelement(gender; users.gender)
                {
                }
                fieldelement(DOB; users.DOB)
                {
                }
                fieldelement(status; users.status)
                {
                }

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(ExportGroup)
                {
                    Caption = 'Export Users';
                    field(ExportFileName; FileName)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specify the file name for the export.';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
                action(ExportAction)
                {
                    Caption = 'Export';
                    ToolTip = 'Click to export users.';
                    trigger OnAction()
                    begin
                        Xmlport.Run(50104, true, true);
                    end;
                }
            }
        }
    }

}
