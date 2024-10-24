codeunit 50106 "Base API"
{
    procedure HandleRequest(Request: Text): Text
    var
        RequestParser: JsonObject;
        RequestAction: JsonToken;
        RequestPayload: JsonToken;
        Payload: JsonToken;
    begin
        // Request variable
        //          {
        //             "action": "GET_MEMBER_DETAILS",
        //             "payload": {
        //   "page": 1,
        //   "page_size": 10
        // }
        //         }
        RequestParser.ReadFrom(Request);
        RequestParser.SelectToken('$.action', RequestAction);
        RequestParser.SelectToken('$.payload', RequestPayload);

        // API actions here
        case RequestAction.AsValue().AsText() of
            'GET_MEMBER_DETAILS':
                exit(GetMemberDetails(RequestPayload.AsObject));
            'GET_USERS':
                exit(GetUsers(RequestPayload.AsObject));
            'Get_Specific_User':
                exit(GetSpecificUser(RequestPayload.AsObject));
            'Update_Specific_User':
                exit(UpdateSpecificUser(RequestPayload.AsObject));
            'Delete_User':
                exit(DeleteUser(RequestPayload.AsObject));
            'Insert_User':
                exit(InsertUser(RequestPayload.AsObject));
            else
                exit(UnsupportedAction(RequestAction.AsValue.AsText))
        end;
    end;

    local procedure GetMemberDetails(Payload: JsonObject): Text
    var
        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Response: Text;
    begin
        // Payload
        //
        // {
        //     "api_request_id": "df3e7cf5-1e4b-41ef-a22f-e755be665432",
        //     "identifier_type": "MSISDN",
        //     "identifier": "254712345678",
        //     "password": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
        // }

        // Process payload here...

        // SUCCESS Response
        //
        // {
        //     "status": "SUCCESS",
        //     "status_description": "Member Details Fetched Successfully",
        //     "data": {
        //         "name": "Carlton Moseti",
        //         "address": "Westlands Nairobi"
        //     }
        // }

        // ERROR Response
        // 
        // {
        //     "status": "ERROR",
        //     "status_description": "Error message...",
        //     "errors": []
        // }

        ResponseData.Add('name', 'Carlton Moseti');
        ResponseData.Add('address', 'Westlands Nairobi');

        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Member Details Fetched Successfully');
        ResponseObject.Add('data', ResponseData);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetUsers(Payload: JsonObject): Text

    var
        page: JsonToken;
        page_size: JsonToken;

        Offset: Integer;
        Counter: Integer;

        Users: Record Users;

        ResponseObject: JsonObject;
        Data: JsonArray;
        Datum: JsonObject;
        Response: Text;
    begin
        // Process payload here...
        if not Payload.SelectToken('page', page) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('description', 'Page number value is missing in the request');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        if not Payload.SelectToken('page_size', page_size) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('description', 'Page size value is missing in the request');
            ResponseObject.Add('data', Data);
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;

        // Pagination
        Users.Reset;
        if Users.FindSet then begin
            Offset := (page.AsValue.AsInteger - 1) * page_size.AsValue.AsInteger();
            Users.Next(Offset);
            Counter := 0;

            repeat begin
                Clear(Datum);

                Datum.Add('member_id', Users."MemberID");
                Datum.Add('first_name', Users."firstName");
                Datum.Add('second_name', Users."secondName");
                Datum.Add('surname', Users."surname");
                Datum.Add('phone_no', Users."Phone_No");
                Datum.Add('email_id', Users."emailID");
                Datum.Add('date_of_birth', Users."DOB");
                Datum.Add('status', Format(Users.status));
                Datum.Add('created_at', Users."createdAt");
                Datum.Add('created_by', Users."createdBy");
                Datum.Add('modified_at', Users."modifiedAt");
                Datum.Add('modified_by', Users."modifiedBy");

                Data.Add(Datum);
                Counter += 1;
            end until (Users.Next = 0) or (Counter = page_size.AsValue.AsInteger);
        end;
        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('description', 'Request is successful');
        ResponseObject.Add('data', Data);
        // AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure GetSpecificUser(Payload: JsonObject): Text
    var
        // Parse the incoming request
        // JSONParser: JsonObject;
        Users: Record Users;

        member_id_filter: JsonToken;

        ResponseObject: JsonObject;
        Datum: JsonObject;
        Data: JsonArray;
        Response: Text;
        member_id: Integer;
    begin
        Users.Reset;

        // Parse the JSON request
        //JSONParser.ReadFrom(Payload);

        // Get member_id from the request and store it in member_id_filter
        if not Payload.Get('member_id', member_id_filter) then begin
            ResponseObject.Add('status', 'Error');
            ResponseObject.Add('status_description', 'member id is missing in the request');
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Convert to  Integer
        member_id := member_id_filter.AsValue().AsInteger();

        Users.SetRange("MemberID", member_id);

        // Check if the user  exists
        if Users.FindFirst() then begin

            //repeat

            Clear(Datum);

            // Add user details to the SampleAccount JSON object
            Datum.Add('member_id', Users."MemberID");
            Datum.Add('first_name', Users."firstName");
            Datum.Add('second_name', Users."secondName");
            Datum.Add('surname', Users."surname");
            Datum.Add('phone_no', Users."Phone_No");
            Datum.Add('email_id', Users."emailID");
            Datum.Add('date_of_birth', Users."DOB");
            Datum.Add('status', Format(Users.status));
            Datum.Add('created_at', Users."createdAt");
            Datum.Add('created_by', Users."createdBy");
            Datum.Add('modified_at', Users."modifiedAt");
            Datum.Add('modified_by', Users."modifiedBy");

            Data.Add(Datum);

            // until Users.Next = 0;

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', 'User has been fetched successfully');
            ResponseObject.Add('data', Datum);
            AddDateTimeToResponse(ResponseObject);

        end else begin
            ResponseObject.Add('status', 'ERROR');
            //Replaces %1 field in a string with the values you provide as optional parameters.
            ResponseObject.Add('status_description', STRSUBSTNO('member id %1 does not exist', member_id));
            AddDateTimeToResponse(ResponseObject);

        end;

        // Convert the JSON response object to text
        ResponseObject.WriteTo(Response);

        // Return the JSON text response
        exit(Response);
    end;

    local procedure UpdateSpecificUser(Payload: JsonObject): Text
    var
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

        // Get member_id from the request
        if not Payload.Get('member_id', varA) then begin
            ResponseObject.Add('status', 'Error');
            ResponseObject.Add('status_description', 'Member ID is missing in the request');
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
            exit(Response);
        end;

        // Convert member_id to Integer
        member_id := varA.AsValue().AsInteger();

        // Find user using the member_id
        Users.SetRange("MemberID", member_id);

        if Users.FindFirst() then begin

            if Payload.Get('first_name', varA) then begin
                first_name := varA.AsValue().AsText();

                Users."firstName" := first_name;
                Users.Validate("firstName");
            end;

            if Payload.Get('second_name', varA) then begin
                second_name := varA.AsValue().AsText();
                Users."secondName" := second_name;
                Users.Validate("secondName");
            end;

            if Payload.Get('surname', varA) then begin
                Surname := varA.AsValue().AsText();
                Users."surname" := Surname;
                Users.Validate("surname");
            end;

            if Payload.Get('phone_no', varA) then begin
                phone_no := varA.AsValue().AsText();
                Users."Phone_No" := phone_no;
                Users.Validate("Phone_No");
            end;

            if Payload.Get('email_id', varA) then begin
                email_id := varA.AsValue().AsText();
                Users."emailID" := email_id;
                Users.Validate("emailID");
            end;

            if Payload.Get('date_of_birth', varA) then begin
                date_of_birth := varA.AsValue().AsDate();
                Users."DOB" := date_of_birth;
            end;

            Users.Modify(true);

            ResponseObject.Add('status', 'SUCCESS');
            ResponseObject.Add('status_description', STRSUBSTNO('User %1 has been updated successfully', member_id));
            AddDateTimeToResponse(ResponseObject);
            ResponseObject.WriteTo(Response);
        end else begin
            // User not found
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', STRSUBSTNO('User ID %1 does not exist', member_id));
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);
        end;

        // Convert the JSON response object to text
        ResponseObject.WriteTo(Response);

        // Return the JSON text response
        exit(Response);
    end;

    procedure DeleteUser(Payload: JsonObject): Text
    var
        Users: Record Users;

        member_id_filter: JsonToken;

        ResponseObject: JsonObject;
        Response: Text;
        member_id: Integer;

    begin
        Users.Reset;

        // Get member_id from the request and store it in member_id_filter
        if not Payload.Get('member_id', member_id_filter) then begin
            ResponseObject.Add('status', 'Error');
            ResponseObject.Add('status_description', 'member id %1 is missing in the request');
            AddDateTimeToResponse(ResponseObject);
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
            AddDateTimeToResponse(ResponseObject);

        end else begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', STRSUBSTNO('User with member id %1 does not exist', member_id));
            AddDateTimeToResponse(ResponseObject);
        end;

        // Convert the JSON response object to text
        ResponseObject.WriteTo(Response);

        // Return the JSON text response
        exit(Response);
    end;

    procedure InsertUser(Payload: JsonObject): Text
    var
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

        //checks if first name exist in the request if true value is stored in var first name

        if not Payload.Get('first_name', varA) then begin
            // Add status and data to the response JSON object
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'First Name is missing');
            AddDateTimeToResponse(ResponseObject);

            // Convert JSON response object to text
            ResponseObject.WriteTo(Response);

            // Return JSON text/string
            exit(Response);
        end;
        FirstName := varA.AsValue().AsText();

        if not Payload.Get('second_name', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Second Name is Missing');
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);

        end;
        SecondName := varA.AsValue().AsText();


        if not Payload.Get('surname', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'surname is Missing');
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);

        end;
        Surname := varA.AsValue().AsText();


        if not Payload.Get('phone_no', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Phone Number is missing');
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);

        end;
        PhoneNo := varA.AsValue().AsText();


        if not Payload.Get('email_id', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Email is missing');
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);

        end;
        EmailID := varA.AsValue().AsText();


        if not Payload.Get('gender', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Gender is missing');
            AddDateTimeToResponse(ResponseObject);

            ResponseObject.WriteTo(Response);

            exit(Response);
        end;
        Gender := LOWERCASE(varA.AsValue().AsText());


        if not Payload.Get('date_of_birth', varA) then begin
            ResponseObject.Add('status', 'ERROR');
            ResponseObject.Add('status_description', 'Date of Birth is missing');
            AddDateTimeToResponse(ResponseObject);

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
                AddDateTimeToResponse(ResponseObject);

                ResponseObject.WriteTo(Response);
                exit(Response);
            end;
        end;

        Users."DOB" := DOB;

        Users.Insert(true);


        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'User has been inserted successfully');
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);


        exit(Response);

    end;



    local procedure UnsupportedAction(RequestAction: Text): Text
    var
        ResponseObject: JsonObject;
        Errors: JsonArray;
        Response: Text;
    begin
        ResponseObject.Add('status', 'ERROR');
        ResponseObject.Add('description', 'The requested action ' + RequestAction + ' is NOT supported.');
        ResponseObject.Add('errors', Errors);
        AddDateTimeToResponse(ResponseObject);

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    local procedure AddDateTimeToResponse(var ResponseObject: JsonObject)
    begin
        ResponseObject.Add('date_time', FORMAT(CurrentDateTime, 0, '<Day,2>-<Month,2>-<Year> <Hours24,2>:<Minutes,2>:<Seconds,2>'));
    end;
}