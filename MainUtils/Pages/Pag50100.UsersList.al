namespace ALProject.ALProject;

page 50100 UsersList
{
    ApplicationArea = All;
    Caption = 'UsersList';
    PageType = List;
    SourceTable = Users;
    UsageCategory = Lists;
    // Linking List to UsersList to card
    CardPageId = UsersCard;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("MemberID"; Rec."MemberID")
                {
                    ToolTip = 'Specifies the value of the MemberID field.', Comment = '%';
                    Editable = false;
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
                 field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.', Comment = '%';
                }
                field(DOB; Rec.DOB)
                {
                    ToolTip = 'Specifies the value of the DOB field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';

                }
                field(CreatedAt; Rec.CreatedAt)
                {
                    ToolTip = 'Specifies the value of the CreatedAt field.', Comment = '%';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the CreatedBy field.', Comment = '%';
                }
                field(ModifiedAt; Rec.ModifiedAt)
                {
                    ToolTip = 'specifies the value of theModifiedAt', Comment = '%';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'spcifies the value of ModifiedBy', Comment = '%';
                }
            }
        }
    }
}
