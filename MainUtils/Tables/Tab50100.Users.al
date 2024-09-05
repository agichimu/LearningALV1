table 50100 Users
{
    Caption = 'Users';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "MemberID"; Integer)
        {
            Caption = 'Member ID';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }
        field(2; firstName; Text[50])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate()

            var
                InvalidCharacters: Text;
            begin
                InvalidCharacters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ';

                if ContainsInvalidCharacters(Rec.firstName, InvalidCharacters) then
                    Error('First Name contains invalid characters.');

                if StrLen(Rec.firstName) < 2 then
                    Error('First Name must be at least 2 characters long.');

                rec.firstName := UPPERCASE(firstName);
            end;
        }
        field(3; secondName; Text[50])
        {
            Caption = 'Second Name';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()

            var
                InvalidCharacters: Text;
            begin
                InvalidCharacters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ';

                if ContainsInvalidCharacters(secondName, InvalidCharacters) then
                    Error('Second Name contains invalid characters.');

                if StrLen(secondName) < 2 then
                    Error('Second Name must be at least 2 characters long.');

                secondName := UPPERCASE(secondName);
            end;
        }
        field(4; surname; Text[50])
        {
            Caption = 'Surname';
            DataClassification = ToBeClassified;

            trigger OnValidate()

            var
                InvalidCharacters: Text;
            begin
                InvalidCharacters := '1234567890!@#$%^&*()_~{}[];:"|\ ,./<>?-= ';

                if ContainsInvalidCharacters(surname, InvalidCharacters) then
                    Error('Surname Name contains invalid characters.');

                if StrLen(surname) < 2 then
                    Error('Surname Name must be at least 2 characters long.');

                surname := UPPERCASE(surname);
            end;
        }
        field(5; "Phone_No"; Code[20])
        {
            Caption = 'Phone No';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Phonenumberisduplicate("Phone_No") then
                    Error('Error Phone Number already exists');
            end;
        }

        field(6; emailID; Text[50])
        {
            Caption = 'Email ID';
            DataClassification = ToBeClassified;
        }
        field(7; gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = 'Male,Female,Others';
            OptionMembers = Male,Female,Others;
            DataClassification = ToBeClassified;
        }
        field(8; "DOB"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = ToBeClassified;
        }
        field(9; status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'New,Dormant,Active,Deceased';
            OptionMembers = New,Dormant,Active,Deceased;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(10; createdAt; DateTime)
        {
            Caption = 'Time Created';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(11; createdBy; Text[50])
        {
            Caption = 'Created By';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(12; modifiedAt; DateTime)
        {
            Caption = 'Date Modified';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(13; modifiedBy; Text[50])
        {
            Caption = 'Modified By';
            Editable = false;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "MemberID")
        {
            Clustered = true;
        }

        key(PhoneIndex; "Phone_No")
        {

        }

        key(firstNameIndex; "firstName")
        {

        }

        key(surname; "surname")
        {

        }

        key(gender; "gender")
        {

        }
    }

    trigger OnInsert()
    begin
        Rec.TestField(firstName);
        Rec.TestField(secondName);
        Rec.TestField("Phone_No");
        Rec.TestField(DOB);
        Rec.TestField(emailID);

        createdAt := CurrentDateTime();
        createdBy := UserId();
    end;

    trigger OnModify()
    begin
        Rec.TestField(firstName);
        Rec.TestField(secondName);
        Rec.TestField("Phone_No");
        Rec.TestField(emailID);
        Rec.TestField(DOB);

        modifiedAt := CurrentDateTime();
        modifiedBy := UserId();
    end;

    procedure ContainsInvalidCharacters(InputText: Text; InvalidChars: Text): Boolean
    var
        i: Integer;
    begin
        for i := 1 to StrLen(InputText) do begin
            if StrPos(InvalidChars, InputText[i]) > 0 then
                exit(true);
        end;
        exit(false);
    end;

    procedure Phonenumberisduplicate(PhoneNumber: Text[20]): Boolean
    var
        UsersRec: Record Users;
    begin
        UsersRec.SetRange("Phone_No", PhoneNumber);
        if UsersRec.FindFirst() then
            exit(true)
        else
            exit(false);
    end;
}