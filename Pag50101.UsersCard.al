namespace ALProject.ALProject;

page 50101 UsersCard
{
    ApplicationArea = All;
    Caption = 'UsersCard';
    PageType = Card;
    Permissions =
        tabledata Users = RIMD;
    SourceTable = Users;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("MemberID"; Rec."MemberID")
                {
                    ToolTip = 'Specifies the value of the MemberID field.', Comment = '%';
                }
                field(firstName; Rec.firstName)
                {
                    ToolTip = 'Specifies the value of the firstName field.', Comment = '%';
                }
                field(SecondName; Rec.SecondName)
                {
                    ToolTip = 'Specifies the value of the SecondName field.', Comment = '%';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.', Comment = '%';
                }
                field(Phone_No; Rec.Phone_No)
                {
                    ToolTip = 'Specifies the value of the Phone_No field.', Comment = '%';
                }
                field(EmailID; Rec.EmailID)
                {
                    ToolTip = 'Specifies the value of the EmailID field.', Comment = '%';
                }
                field(DOB; Rec.DOB)
                {
                    ToolTip = 'Specifies the value of the DOB field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
