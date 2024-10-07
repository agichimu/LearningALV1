namespace LearningAl.LearningAl;

codeunit 50101 Calculator
{
    procedure Sum(varA: Integer; varB: Integer): Integer
    begin
        exit(varA + varB)
    end;

    procedure SumV2(Request: Text): Text
    var
        JSONParser: JsonObject;
        varA: JsonToken; 
        varB: JsonToken;
        Result: Integer;

        ResponseObject: JsonObject;
        Response: Text;
        Total: Integer;
    begin
        JSONParser.ReadFrom(Request);

        JSONParser.Get('a', varA);
        JSONParser.Get('b', varB);

        Result := varA.AsValue().AsInteger() + varB.AsValue().AsInteger();

        ResponseObject.Add('result', Result);
        ResponseObject.Add('date', CurrentDateTime());
        ResponseObject.Add('user', UserId());
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    procedure Multiply(varA: Integer; varB: Integer): Integer
    begin
        exit(varA * varB)
    end;

    procedure MultiplyV2(Request: Text): Text
    var
        JSONParser: JsonObject;
        varA: JsonToken;
        varB: JsonToken;
        Result: Integer;

        ResponseObject: JsonObject;
        Response: Text;
    begin
        JSONParser.ReadFrom(Request);

        JSONParser.Get('a', varA);
        JSONParser.Get('b', varB);

        Result := varA.AsValue().AsInteger() * varB.AsValue().AsInteger();

        ResponseObject.Add('result', Result);
        ResponseObject.Add('date', CurrentDateTime());
        ResponseObject.Add('user', UserId());

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    procedure Divide(varA: Integer; varB: Integer): Integer
    begin
        exit(varA / varB)
    end;

    procedure DivideV2(Request: Text): Text
    var
        JSONParser: JsonObject;
        varA: JsonToken;
        varB: JsonToken;
        Result: Integer;


        ResponseObject: JsonObject;
        Response: Text;
        Total: Integer;
    begin
        JSONParser.ReadFrom(Request);

        JSONParser.Get('a', varA);
        JSONParser.Get('b', varB);

        Result := varA.AsValue().AsInteger() / varB.AsValue().AsInteger();

        ResponseObject.Add('result', Result);
        ResponseObject.Add('date', CurrentDateTime());
        ResponseObject.Add('user', UserId());
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    procedure SumJSON(varA: Integer; varB: Integer): Text
    var
        ResponseObject: JsonObject;
        Response: Text;
        Total: Integer;
    begin
        Total := varA + varB;

        ResponseObject.Add('result', Total);
        ResponseObject.Add('date', CurrentDateTime());
        ResponseObject.Add('user', UserId());

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    procedure MultiplyJSON(varA: Integer; varB: Integer): Text
    var
        ResponseObject: JsonObject;
        Response: Text;
        Total: Integer;
    begin
        Total := varA * varB;

        ResponseObject.Add('result', Total);
        ResponseObject.Add('date', CurrentDateTime());
        ResponseObject.Add('user', UserId());

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;

    procedure DivideJSON(varA: Integer; varB: Integer): Text
    var
        ResponseObject: JsonObject;
        Response: Text;
        Total: Integer;
    begin
        Total := varA / varB;

        ResponseObject.Add('result', Total);
        ResponseObject.Add('date', CurrentDateTime());
        ResponseObject.Add('user', UserId());

        ResponseObject.WriteTo(Response);

        exit(Response);
    end;


    procedure joinString(Request: Text): Text
    var
        JSONParser: JsonObject;
        Value1: JsonToken;
        Value2: JsonToken;
        Result: Text;

        ResponseObject: JsonObject;
        Response: Text;
        Total: Integer;
    begin
        JSONParser.ReadFrom(Request);

        JSONParser.Get('a', Value1);
        JSONParser.Get('b', Value2);

        Result := Value1.AsValue().AsText() + ' ' + Value2.AsValue().AsText();

        ResponseObject.Add('result', Result);
        ResponseObject.Add('date', CurrentDateTime());
        ResponseObject.Add('user', UserId());
        ResponseObject.WriteTo(Response);

        exit(Response);
    end;
}