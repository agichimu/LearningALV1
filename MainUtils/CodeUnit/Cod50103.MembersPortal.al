namespace LearningAl.LearningAl;

codeunit 50103 MembersPortal
{
    procedure GetMemberDetails(Request: Text): Text
    var
        RequestParser: JsonObject;

        Payload: JsonToken;
        IdentifierType: JsonToken;
        Identifier: JsonToken;

        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Response: Text;
    begin
        /*
        SAMPLE EXPECTED REQUEST FROM INTEGRATION DOCS.
        {
            "action": "GET_MEMBER_DETAILS",
            "payload": {
                "api_request_id": "df3e7cf5-1e4b-41ef-a22f-e755be665432",
                "identifier_type": "MSISDN",
                "identifier": "254712345678",
                "password": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
            }
        }
        */
        // 1. Convert request string/text data to JsonObject
        RequestParser.ReadFrom(Request);

        // 2. Get relevant request data from the JsonObject
        RequestParser.Get('payload', Payload);

        Payload.AsObject().Get('identifier', Identifier);
        Payload.AsObject().Get('identifier_type', IdentifierType);

        // 3. Custom code logic. E.g Validations, Get Data, Handle Authentication e.t.c
        // ...
        // ..
        // .
        ResponseData.Add('member_number', '123456789');
        ResponseData.Add('name', 'MOSES ODUOR');
        ResponseData.Add('id_number', '123456789');
        ResponseData.Add('phone_number', '254712345678');
        ResponseData.Add('location', '001 MOMBASA');
        ResponseData.Add('date_of_birth', '1 Dec 1990');
        ResponseData.Add('email_address', 'moses@gmail.com');


        // 4. Prepare JSON response object
        /*
        SAMPLE EXPECTED RESPONSE: SUCCESS i.e if member is found
        {
            "status": "SUCCESS",
            "status_description": "Member Details Fetched Successfully",
            "data": {
                "member_number": "123456789",
                "name": "MOSES ODUOR",
                "id_number": "123456789",
                "phone_number": "254712345678",
                "location": "001 MOMBASA",
                "date_of_birth": "1 Dec 1990",
                "email_address": "moses@gmail.com"
            }
        }
        */
        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Member Details Fetched Successfully');
        ResponseObject.Add('data', ResponseData);

        /*
        SAMPLE EXPECTED RESPONSE: ERROR/FAILED/NOT_FOUND i.e if member is NOT found
        {
            "status": "NOT_FOUND",
            "status_description": "Member NOT found",
        }
        */
        // ResponseObject.Add('status', 'NOT_FOUND');
        // ResponseObject.Add('status_description', 'Member NOT found');

        // 5. Convert JSON response object to text
        ResponseObject.WriteTo(Response);

        // 6. Return JSON text/string
        exit(Response)
    end;

    procedure GetAccounts(Request: Text): Text
    var
        RequestParser: JsonObject;

        Payload: JsonToken;
        IdentifierType: JsonToken;
        Identifier: JsonToken;

        ResponseObject: JsonObject;
        SampleAccount: JsonObject;
        ResponseData: JsonArray;
        Response: Text;
    begin
        /*
        SAMPLE EXPECTED REQUEST FROM INTEGRATION DOCS.
        {
            "action": "GET_ACCOUNTS",
            "payload": {
                "api_request_id": "df3e7cf5-1e4b-41ef-a22f-e755be665432",
                "identifier_type": "MSISDN",
                "identifier": "254712345678",
                "password":"5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"
            }
        }
        */
        // 1. Convert request string/text data to JsonObject
        RequestParser.ReadFrom(Request);

        // 2. Get relevant request data from the JsonObject
        RequestParser.Get('payload', Payload);

        Payload.AsObject().Get('identifier', Identifier);
        Payload.AsObject().Get('identifier_type', IdentifierType);

        // 3. Custom code logic. E.g Validations, Get Data, Handle Authentication e.t.c
        // ...
        // ..
        // .
        SampleAccount.Add('account_number', '5050123278000');
        SampleAccount.Add('account_name', 'FOSA Savings Account');
        SampleAccount.Add('account_type', 'FOSA Account');
        SampleAccount.Add('account_status', 'Active');
        SampleAccount.Add('currency', 'KES');
        SampleAccount.Add('book_balance', '1,000');
        SampleAccount.Add('available_balance', '0');
        SampleAccount.Add('actions', 'Deposits and Withdrawals');

        ResponseData.Add(SampleAccount);

        // 4. Prepare JSON response object
        /*
        SAMPLE EXPECTED RESPONSE: SUCCESS i.e if accounts are found
        {
            "status": "SUCCESS",
            "status_description": "Member’s accounts list has been fetched successfully",
            "data": [
                {
                    "account_number": "5050123278000",
                    "account_name": "FOSA Savings Account",
                    "account_type": "FOSA Account",
                    "account_status": "Active",
                    "currency": "KES",
                    "book_balance": "1,000",
                    "available_balance": "0",
                    "actions": "Deposits and Withdrawals"
                },
                {
                    "account_number": "020123278",
                    "account_name": "Member Deposits Contribution",
                    "account_type": "BOSA Account",
                    "account_status": "Active",
                    "currency": "KES",
                    "book_balance": "991,065.46",
                    "available_balance": "991,065.46",
                    "actions": "Deposits" 
                }
            ]
        }
        */
        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Member accounts list has been fetched successfully');
        ResponseObject.Add('data', ResponseData);

        // 5. Convert JSON response object to text
        ResponseObject.WriteTo(Response);

        // 6. Return JSON text/string
        exit(Response)
    end;

    procedure CreateNextOfKin(Request: Text): Text
    var
        RequestParser: JsonObject;

        Payload: JsonToken;
        IdentifierType: JsonToken;
        Identifier: JsonToken;
        NextOfKinList: JsonToken;

        ResponseObject: JsonObject;
        ResponseData: JsonObject;
        Response: Text;
    begin
        /*
        SAMPLE EXPECTED REQUEST FROM INTEGRATION DOCS.
        {
            "action": "CREATE_NEXT_OF_KIN",
            "payload": {
                "api_request_id": "df3e7cf5-1e4b-41ef-a22f-e755be665432",
                "identifier_type": "MSISDN",
                "identifier": "254712345678",
                "password": "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8",
                "list": [
                    {
                        "full_names": "Mary Doe",
                        "relationship": "WIFE",
                        "allocation": 50
                    },
                    {
                        "full_names": "John Doe",
                        "relationship": "SON",
                        "allocation": 25
                    },
                    {
                        "full_names": "Jane Doe",
                        "relationship": "DAUGHTER",
                        "allocation": 25
                    }
                ]
            }
        }
        */
        // 1. Convert request string/text data to JsonObject
        RequestParser.ReadFrom(Request);

        // 2. Get relevant request data from the JsonObject
        RequestParser.Get('payload', Payload);

        Payload.AsObject().Get('identifier', Identifier);
        Payload.AsObject().Get('identifier_type', IdentifierType);
        Payload.AsObject().Get('list', NextOfKinList);

        // 3. Custom code logic. E.g Validations, Get Data, Handle Authentication e.t.c
        // ...
        // ..
        // .

        // NextOfKinList.AsArray() - Loop through the array items as you insert/create next of kin...

        // TODO: Exception handling.

        // 4. Prepare JSON response object
        /*
        SAMPLE EXPECTED RESPONSE: SUCCESS i.e if creation was successful
        {
            "status": "SUCCESS",
            "status_description": "Member's next of kin have been created successfully"
        }
        */
        ResponseObject.Add('status', 'SUCCESS');
        ResponseObject.Add('status_description', 'Member next of kin have been created successfully');

        // 5. Convert JSON response object to text
        ResponseObject.WriteTo(Response);

        // 6. Return JSON text/string
        exit(Response)
    end;

    procedure TestSum(Num1: Integer; Num2: Integer): Integer
    begin
        exit(Num1 + Num2);
    end;
}
