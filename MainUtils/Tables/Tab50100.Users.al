table 50100 Users
{
    Caption = 'Users';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "MemberID"; Integer)
        {
            Caption = 'MemberID';
            AutoIncrement = true;  
            DataClassification = SystemMetadata; 
        }
        field(2; firstName; Text[50])
        {
            Caption = 'firstName';
            DataClassification = ToBeClassified;
        }
        field(3; SecondName; Text[50])
        {
            Caption = 'SecondName';
            DataClassification = ToBeClassified;
        }
        field(4; Surname; Text[50])
        {
            Caption = 'Surname';
            DataClassification = ToBeClassified;
        }
        field(5; "Phone_No"; Code[13])
        {
            Caption = 'Phone_No';
            DataClassification = ToBeClassified;
        }
        field(6; EmailID; Text[50])
        {
            Caption = 'EmailID';
            DataClassification = ToBeClassified;
        }
        field(7; "DOB"; DateTime)
        {
            Caption = 'DOB';
            DataClassification = ToBeClassified;
        }
        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'New,Dormant,Active,Deseased';
            OptionMembers = New,Dormant,Active,Deseased;
            DataClassification = ToBeClassified;
        }

        field(9; CreatedAt; DateTime)
        {
            Caption = 'Time Created';
            DataClassification = SystemMetadata;
        }
        field(10; CreatedBy; Text[50])
        {
            Caption = 'Created By';
            DataClassification = SystemMetadata;
        }
        field(11; ModifiedAt; DateTime)
        {
            Caption = 'Time Modified';
            DataClassification = SystemMetadata;
        }
        field(12; ModifiedBy; Text[50])
        {
            Caption = 'Modified By';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "MemberID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        CreatedAt := CurrentDateTime();
        CreatedBy := UserId();
    end;

    trigger OnModify()
    begin
        ModifiedAt := CurrentDateTime();
        ModifiedBy := UserId();
    end;
}
