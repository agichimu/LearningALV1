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
                // fieldelement(MemberID; users.MemberID)
                // {
                // }
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
                // fieldelement(createdAt; users.createdAt)
                // {
                // }
                // fieldelement(createdBy; users.createdBy)
                // {
                // }
                // fieldelement(modifiedAt; users.modifiedAt)
                // {
                // }
                // fieldelement(modifiedBy; users.modifiedBy)
                // {
                // }

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
}
