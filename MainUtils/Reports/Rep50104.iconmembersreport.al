namespace LearningAl.LearningAl;

report 50104 "iconmembers report"
{
    ApplicationArea = All;
    Caption = 'iconmembers report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './LearningAl/members.rdl';

    dataset
    {
        dataitem(Users; Users)
        {
            column(MemberID; MemberID)
            {
            }
            column(firstName; firstName)
            {
            }
            column(secondName; secondName)
            {
            }
            column(surname; surname)
            {
            }
            column(Phone_No; Phone_No)
            {
            }
            column(emailID; emailID)
            {
            }
            column(gender; gender)
            {
            }
            column(DOB; DOB)
            {
            }
            column(status; status)
            {
            }
            column(createdAt; createdAt)
            {
            }
            column(createdBy; createdBy)
            {
            }
            column(modifiedAt; modifiedAt)
            {
            }
            column(modifiedBy; modifiedBy)
            {
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
