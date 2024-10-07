namespace LearningAl.LearningAl;

page 50103 "API savannah User page"
{
    APIGroup = 'api';
    APIPublisher = 'savannahventures';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'savannahUserPage';
    DelayedInsert = true;
    EntityName = 'savannahUser';
    EntitySetName = 'savannahUser';
    PageType = API;
    SourceTable = users;

    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(memberID; Rec.MemberID)
                {
                    Caption = 'Member ID';
                    Editable = false;
                }
                field(firstName; Rec.firstName)
                {
                    Caption = 'First Name';
                }
                field(secondName; Rec.secondName)
                {
                    Caption = 'Second Name';
                }
                field(surname; Rec.surname)
                {
                    Caption = 'Surname';
                }
                field(phoneNo; Rec.Phone_No)
                {
                    Caption = 'Phone No';
                }
                field(emailID; Rec.emailID)
                {
                    Caption = 'Email ID';
                }
                field(gender; Rec.gender)
                {
                    Caption = 'Gender';
                }
                field(dob; Rec.DOB)
                {
                    Caption = 'Date of Birth';
                }
                field(status; Rec.status)
                {
                    Caption = 'Status';
                }
                field(createdAt; Rec.createdAt)
                {
                    Caption = 'Time Created';
                }
                field(createdBy; Rec.createdBy)
                {
                    Caption = 'Created By';
                }
                field(modifiedAt; Rec.modifiedAt)
                {
                    Caption = 'Date Modified';
                }
                field(modifiedBy; Rec.modifiedBy)
                {
                    Caption = 'Modified By';
                }
            }
        }
    }
}
