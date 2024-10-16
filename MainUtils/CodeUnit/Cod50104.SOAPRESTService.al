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
        ResponseData: JsonArray;
        Response: Text;
    begin
        // Fetch all users and add to JSON response
        Users.Reset;

        if Users.FindSet then begin
            repeat begin
                Clear(SampleAccount);

                SampleAccount.Add('user_security_id', Users."User Security ID");
                SampleAccount.Add('user_name', Users."User Name");
                SampleAccount.Add('full_name', Users."Full Name");
                // Convert Option type 'State' to string
                SampleAccount.Add('state', FORMAT(Users."State"));
                SampleAccount.Add('expiry_date', Users."Expiry Date");
                SampleAccount.Add('windows_security_id', Users."Windows Security ID");
                SampleAccount.Add('change_password', Users."Change Password");
                // Convert Option type 'License Type' to string
                SampleAccount.Add('license_type', Format(Users."License Type"));
                SampleAccount.Add('authentication_email', Users."Authentication Email");
                SampleAccount.Add('contact_email', Users."Contact Email");
                SampleAccount.Add('exchange_identifier', Users."Exchange Identifier");
                SampleAccount.Add('application_id', Users."Application ID");

                ResponseData.Add(SampleAccount);
            end until Users.Next = 0;
        end;

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Users list has been fetched successfully');
        ResponseObject.Add('data', ResponseData);

        // 5. Convert JSON response object to text
        ResponseObject.WriteTo(Response);

        // 6. Return JSON text/string
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
            ResponseObject.Add('status_description', 'Email Address');

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