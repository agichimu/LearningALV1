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
                    Editable = false;
                }
                field(firstName; Rec.firstName)
                {
                    ToolTip = 'Specifies the value of the firstName field.', Comment = '%';
                    ShowMandatory = true;

                }
                field(SecondName; Rec.SecondName)
                {
                    ToolTip = 'Specifies the value of the SecondName field.', Comment = '%';
                    ShowMandatory = true;
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.', Comment = '%';
                }
                field(Phone_No; Rec.Phone_No)
                {
                    ToolTip = 'Specifies the value of the Phone_No field.', Comment = '%';
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        Rec.TestField("Phone_No");
                    end;
                }
                field(EmailID; Rec.EmailID)
                {
                    ToolTip = 'Specifies the value of the EmailID field.', Comment = '%';
                    ShowMandatory = true;
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.', Comment = '%';
                    ShowMandatory = true;
                }
                field(DOB; Rec.DOB)
                {
                    ToolTip = 'Specifies the value of the DOB field.', Comment = '%';
                    ShowMandatory = true;
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