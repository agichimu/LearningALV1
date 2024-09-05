namespace LearningAl.LearningAl;

xmlport 50104 exportusers
{
    Caption = 'Export Users';
    Format = VariableText;
    Direction = Export;


    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Users; Users)
            {
                fieldelement(MemberID; Users.MemberID)
                {
                }
                fieldelement(firstName; Users.firstName)
                {
                }
                fieldelement(secondName; Users.secondName)
                {
                }
                fieldelement(surname; Users.surname)
                {
                }
                fieldelement(Phone_No; Users.Phone_No)
                {
                }
                fieldelement(emailID; Users.emailID)
                {
                }
                fieldelement(gender; Users.gender)
                {
                }
                fieldelement(DOB; Users.DOB)
                {
                }
                fieldelement(status; Users.status)
                {
                }
                fieldelement(createdAt; Users.createdAt)
                {
                }
                fieldelement(createdBy; Users.createdBy)
                {
                }
                fieldelement(modifiedAt; Users.modifiedAt)
                {
                }
                fieldelement(modifiedBy; Users.modifiedBy)
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
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
