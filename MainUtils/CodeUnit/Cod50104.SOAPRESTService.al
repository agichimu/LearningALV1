codeunit 50104 "SOAP REST Service"
{
    // procedure HandleRequest(Request: Text): Text
    // var
    //     RequestParser: JsonObject;
    //     RequestAction: JsonToken;
    //     RequestPayload: JsonToken;

    //     HasToken: Boolean;
    // begin
    //     if Request <> '' then begin
    //         RequestParser.ReadFrom(Request);
    //         HasToken := RequestParser.SelectToken('$.action', RequestAction);
    //         HasToken := RequestParser.SelectToken('$.payload', RequestPayload);

    //         // API actions here
    //         case RequestAction.AsValue().AsText() of
    //             'CREATE_USER_REQUEST':
    //                 exit(CreateUserRequest(RequestPayload.AsObject));
    //             'GET_USERS_LIST':
    //                 exit(GetUsersList);
    //             else
    //                 exit(UnsupportedAction(RequestAction.AsValue.AsText));
    //         end;
    //     end else begin
    //         exit('');
    //     end;
    // end;

    // local procedure CreateUserRequest(Payload: JsonObject): Text
    // var
    //     ResponseObject: JsonObject;
    //     ResponseData: JsonObject;
    //     Errors: JsonArray;
    //     Response: Text;
    // begin
    //     // TODO: ...
    // end;

    procedure GetUsersList(): Text
    var
        RequestParser: JsonObject;

        Users: record User;

        Payload: JsonToken;
        IdentifierType: JsonToken;
        Identifier: JsonToken;

        ResponseObject: JsonObject;
        SampleAccount: JsonObject;
        //JSON array to hold all user accounts
        ResponseData: JsonArray;
        // Text variable to store the  response as a string
        Response: Text;
    begin
        // Reset the Users record to start fetching from the beginning
        Users.Reset;

        // Check if there are any users in the table
        if Users.FindSet then begin
            // Loop through all the user records found
            repeat
                // Clear the SampleAccount object for each user
                Clear(SampleAccount);

                // Add 'User Security ID' field to the user object
                SampleAccount.Add('user_security_id', Users."User Security ID");
                SampleAccount.Add('user_name', Users."User Name");
                SampleAccount.Add('full_name', Users."Full Name");
                SampleAccount.Add('state', FORMAT(Users."State"));
                SampleAccount.Add('expiry_date', Users."Expiry Date");
                SampleAccount.Add('windows_security_id', Users."Windows Security ID");
                SampleAccount.Add('change_password', Users."Change Password");
                SampleAccount.Add('license_type', Format(Users."License Type"));
                SampleAccount.Add('authentication_email', Users."Authentication Email");
                SampleAccount.Add('contact_email', Users."Contact Email");
                SampleAccount.Add('exchange_identifier', Users."Exchange Identifier");
                SampleAccount.Add('application_id', Users."Application ID");

                // Add the current user account object to the response array
                ResponseData.Add(SampleAccount);
            // Move to the next user in the Users table
            until Users.Next = 0;
        end;

        // Add success status to the response
        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Users list fetched');
        // Add the user data (array) to the response object
        ResponseObject.Add('data', ResponseData);

        // Convert the final JSON response object to a string
        ResponseObject.WriteTo(Response);

        // Return the JSON string response
        exit(Response)
    end;



    procedure GetUsersListWithFilter(Request: Text): Text
    var
        RequestParser: JsonObject;

        Users: record User;

        Payload: JsonToken;
        IdentifierType: JsonToken;
        Identifier: JsonToken;

        JSONParser: JsonObject;
        StateFilter: JsonToken;
        Result: Text;

        ResponseObject: JsonObject;
        SampleAccount: JsonObject;
        ResponseData: JsonArray;
        Response: Text;

        StateOptions: Option Enabled,Disabled,Others;

    begin
        Users.Reset;

        // Parse JSON request
        JSONParser.ReadFrom(Request);

        // Check if 'state' exists
        if JSONParser.Get('state', StateFilter) then begin
            // Convert to lowercase for comparison
            Result := LOWERCASE(StateFilter.AsValue().AsText());
        end else begin
            Result := 'enabled';
        end;

        if Result = 'enabled' then
            StateOptions := StateOptions::Enabled
        else
            StateOptions := StateOptions::Disabled;

        // Filter the Users record based on the state
        Users.SetRange("State", StateOptions);

        if Users.FindSet then begin
            repeat
                Clear(SampleAccount);

                SampleAccount.Add('user_security_id', Users."User Security ID");
                SampleAccount.Add('user_name', Users."User Name");
                SampleAccount.Add('full_name', Users."Full Name");
                SampleAccount.Add('state', FORMAT(Users."State"));
                SampleAccount.Add('expiry_date', Users."Expiry Date");
                SampleAccount.Add('windows_security_id', Users."Windows Security ID");
                SampleAccount.Add('change_password', Users."Change Password");
                SampleAccount.Add('license_type', FORMAT(Users."License Type"));
                SampleAccount.Add('authentication_email', Users."Authentication Email");
                SampleAccount.Add('contact_email', Users."Contact Email");
                SampleAccount.Add('exchange_identifier', Users."Exchange Identifier");
                SampleAccount.Add('application_id', Users."Application ID");

                ResponseData.Add(SampleAccount);
            until Users.Next = 0;
        end;

        // Add status and data to the response JSON object
        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Users list has been fetched successfully');
        ResponseObject.Add('data', ResponseData);

        // Convert JSON response object to text
        ResponseObject.WriteTo(Response);

        // Return JSON text/string
        exit(Response);
    end;

    procedure InsertUser(Request: Text): Text
    var
        RequestParser: JsonObject;   //parse the incoming JSON data.
        Users: Record Users;
        varA: JsonToken;

        ResponseObject: JsonObject;  //construct the response as a JSON object.
        Response: Text;

        FirstName: Text[50];
        SecondName: Text[50];
        Surname: Text[50];
        PhoneNo: Code[20];
        EmailID: Text[50];
        Gender: Text;
        DOB: Date;
    begin
        RequestParser.ReadFrom(Request);

        //checks if first name exist in the request if true value is stored in var first name

        RequestParser.ReadFrom(Request);

        if not RequestParser.Get('first_name', varA) then begin
            // Add status and data to the response JSON object
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'First Name is missing');

            // Convert JSON response object to text
            ResponseObject.WriteTo(Response);

            // Return JSON text/string
            exit(Response);
        end;
        FirstName := varA.AsValue().AsText();

        if not RequestParser.Get('second_name', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Second Name is Missing');

            ResponseObject.WriteTo(Response);

            exit(Response);

        end;
        SecondName := varA.AsValue().AsText();


        if not RequestParser.Get('surname', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'surname is Missing');

            ResponseObject.WriteTo(Response);

            exit(Response);

        end;
        Surname := varA.AsValue().AsText();


        if not RequestParser.Get('phone_no', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Phone Number is missing');

            ResponseObject.WriteTo(Response);

            exit(Response);

        end;
        PhoneNo := varA.AsValue().AsText();


        if not RequestParser.Get('email_id', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Email is missing');

            ResponseObject.WriteTo(Response);

            exit(Response);

        end;
        EmailID := varA.AsValue().AsText();


        if not RequestParser.Get('gender', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Gender is missing');

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;
        Gender := LOWERCASE(varA.AsValue().AsText());


        if not RequestParser.Get('date_of_birth', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Date of Birth is missing');
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;
        DOB := varA.AsValue().AsDate();

        Users.Init();   // initializes

        Users.firstName := FirstName;
        Users.Validate(firstName);

        Users.secondName := SecondName;
        Users.Validate(secondName);

        Users.surname := Surname;
        Users.Validate(surname);

        Users."Phone_No" := PhoneNo;
        Users.Validate(Phone_No);

        Users.emailID := EmailID;
        users.Validate(emailID);

        case Gender of
            'male':
                Users.gender := Users.gender::Male;
            'female':
                Users.gender := Users.gender::Female;
            else begin
                ResponseObject.Add('status', 'ERROR');
                ResponseObject.Add('status_description', 'Invalid gender specified');
                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        Users."DOB" := DOB;

        Users.Insert(true);


        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'User has been inserted successfully');
        ResponseObject.WriteTo(Response);


        exit(Response);

    end;

    procedure GetUsers(Request: Text): Text
    var
        RequestParser: JsonToken;

        Users: Record Users;

        Payload: JsonToken;
        IdentifierType: JsonToken;
        Identifier: JsonToken;

        ResponseObject: JsonObject;
        SampleAccount: JsonObject;
        ResponseData: JsonArray;
        Response: Text;

    begin
        // Fetch all Users and add them to JSON response
        Users.Reset;

        // Check if there are Users in the table
        if Users.FindSet then begin
            //REPEAT UNTIL loop will loop through all filtered records.
            repeat begin
                Clear(SampleAccount);

                // Add member_id field to the Users Object
                SampleAccount.Add('member_id', Users."MemberID");
                SampleAccount.Add('first_name', Users."firstName");
                SampleAccount.Add('second_name', Users."secondName");
                SampleAccount.Add('surname', Users."surname");
                SampleAccount.Add('phone_no', Users."Phone_No");
                SampleAccount.Add('email_id', Users."emailID");
                SampleAccount.Add('date_of_birth', Users."DOB");
                SampleAccount.Add('status', Users."status");
                SampleAccount.Add('created_at', Users."createdAt");
                SampleAccount.Add('created_by', Users."createdBy");
                SampleAccount.Add('modified_at', Users."modifiedAt");
                SampleAccount.Add('modified_by', Users."modifiedBy");

                // add users object to the response array
                ResponseData.Add(SampleAccount);


            end until Users.Next = 0;
        end;

        // Add success status to the response
        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Users list has been fetched successfully');
        ResponseObject.Add('data', ResponseData);

        // 5. Convert JSON response object to text
        ResponseObject.WriteTo(Response);

        // 6. Return JSON text/string
        exit(Response)
    end;

    procedure GetSpecificUser(Request: Text): Text
    var
        // Parse the incoming request
        RequestParser: JsonToken;
        Users: Record Users;
        Payload: JsonToken;
        IdentifierType: JsonToken;
        Identifier: JsonToken;
        JSONParser: JsonObject;
        member_id_filter: JsonToken;
        Resut: Text;
        ResponseObject: JsonObject;
        SampleAccount: JsonObject;
        ResponseData: JsonArray;
        Response: Text;
        member_id: Integer;
    begin
        Users.Reset;

        // Parse the JSON request
        JSONParser.ReadFrom(Request);

        // Get member_id from the request and store it in member_id_filter
        if not JSONParser.Get('member_id', member_id_filter) then begin
            ResponseObject.Add('status', 'Error');
            ResponseObject.Add('status_description', 'member id is missing in the request');

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Convert to  Integer
        member_id := member_id_filter.AsValue().AsInteger();

        Users.SetRange("MemberID", member_id);

        // Check if the user  exists
        if Users.FindFirst() then begin

            //repeat

            Clear(SampleAccount);

            // Add user details to the SampleAccount JSON object
            SampleAccount.Add('member_id', Users."MemberID");
            SampleAccount.Add('first_name', Users."firstName");
            SampleAccount.Add('second_name', Users."secondName");
            SampleAccount.Add('surname', Users."surname");
            SampleAccount.Add('phone_no', Users."Phone_No");
            SampleAccount.Add('email_id', Users."emailID");
            SampleAccount.Add('date_of_birth', Users."DOB");
            SampleAccount.Add('status', Format(Users.status));
            SampleAccount.Add('created_at', Users."createdAt");
            SampleAccount.Add('created_by', Users."createdBy");
            SampleAccount.Add('modified_at', Users."modifiedAt");
            SampleAccount.Add('modified_by', Users."modifiedBy");

            ResponseData.Add(SampleAccount);

            // until Users.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'User has been fetched successfully');
            ResponseObject.Add('data', SampleAccount);
        end else begin
            ResponseObject.Add('status', 'ERROR');
            //Replaces %1 field in a string with the values you provide as optional parameters.
            ResponseObject.Add('status_description', STRSUBSTNO('member id %1 does not exist', member_id));
        end;

        // Convert the JSON response object to text
        ResponseObject.WriteTo(Response);

        // Return the JSON text response
        exit(Response);
    end;

    procedure UpdateSpecificUser(Request: Text): Text
    var
        RequestParser: JsonObject; // Parse the incoming JSON data
        Users: Record Users;
        varA: JsonToken;

        ResponseObject: JsonObject;
        Response: Text;

        member_id: Integer;
        first_name: Text[50];
        second_name: Text[50];
        Surname: Text[50];
        phone_no: Code[20];
        email_id: Text[50];
        date_of_birth: Date;
    begin
        Users.Reset;
        RequestParser.ReadFrom(Request); // Parse the JSON request

        // Get member_id from the request
        if not RequestParser.Get('member_id', varA) then begin
            ResponseObject.Add('status', 'Error');
            ResponseObject.Add('status_description', 'Member ID is missing in the request');
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Convert member_id to Integer
        member_id := varA.AsValue().AsInteger();

        // Find user using the member_id
        Users.SetRange("MemberID", member_id);

        if Users.FindFirst() then begin

            if RequestParser.Get('first_name', varA) then begin
                first_name := varA.AsValue().AsText();

                Users."firstName" := first_name;
                Users.Validate("firstName");
            end;

            if RequestParser.Get('second_name', varA) then begin
                second_name := varA.AsValue().AsText();
                Users."secondName" := second_name;
                Users.Validate("secondName");
            end;

            if RequestParser.Get('surname', varA) then begin
                Surname := varA.AsValue().AsText();
                Users."surname" := Surname;
                Users.Validate("surname");
            end;

            if RequestParser.Get('phone_no', varA) then begin
                phone_no := varA.AsValue().AsText();
                Users."Phone_No" := phone_no;
                Users.Validate("Phone_No");
            end;

            if RequestParser.Get('email_id', varA) then begin
                email_id := varA.AsValue().AsText();
                Users."emailID" := email_id;
                Users.Validate("emailID");
            end;

            if RequestParser.Get('date_of_birth', varA) then begin
                date_of_birth := varA.AsValue().AsDate();
                Users."DOB" := date_of_birth;
            end;

            Users.Modify(true);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', STRSUBSTNO('User %1 has been updated successfully', member_id));
            ResponseObject.WriteTo(Response);
        end else begin
            // User not found
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', STRSUBSTNO('User ID %1 does not exist', member_id));
            ResponseObject.WriteTo(Response);
        end;

        // Convert the JSON response object to text
        ResponseObject.WriteTo(Response);

        // Return the JSON text response
        exit(Response);
    end;

    // Delete  
    procedure DeleteUser(Request: Text): Text
    var
        RequestParser: JsonObject;

        Users: Record Users;

        member_id_filter: JsonToken;

        ResponseObject: JsonObject;
        Response: Text;
        member_id: Integer;

    begin
        Users.Reset;

        RequestParser.ReadFrom(Request);  // Parse the JSON request

        // Get member_id from the request and store it in member_id_filter
        if not RequestParser.Get('member_id', member_id_filter) then begin
            ResponseObject.Add('status', 'Error');
            ResponseObject.Add('status_description', 'member id is missing in the request');

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Convert to Integer
        member_id := member_id_filter.AsValue().AsInteger();

        // Set the filter using member_id
        Users.SetRange("MemberID", member_id);

        // Check if the user exists
        if Users.FindFirst() then begin

            Users.Delete(true);  //Deletes a record in a table.

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', STRSUBSTNO('User with member id %1 has been deleted successfully', member_id));
        end else begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', STRSUBSTNO('User with member id %1 does not exist', member_id));
        end;

        // Convert the JSON response object to text
        ResponseObject.WriteTo(Response);

        // Return the JSON text response
        exit(Response);
    end;



    // GLOBAL
    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        // ResponseObject.Add('status', 'ERROR');
        // ResponseObject.Add('description', 'The requested action ' + RequestAction + ' is NOT supported.');
        // ResponseObject.Add('errors', Errors);
        // AddDateTimeToResponse(ResponseObject);

        // ResponseObject.WriteTo(Response);

        // exit(Response);

        Error('The requested action ' + RequestAction + ' is NOT supported.');

        exit(Response);
    end;
}