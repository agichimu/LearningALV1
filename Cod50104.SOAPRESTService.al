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