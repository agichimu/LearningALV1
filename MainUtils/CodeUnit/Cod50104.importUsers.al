codeunit 50105 "Export Users to Excel"
{
    procedure ExportUsersToExcel(var ErrorText: Text): Boolean;
    var
        ExcelBuffer: Record "Excel Buffer";
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        FileName: Text;
        Users: Record Users;
        RowNo: Integer;
    begin
        FileName := 'UsersExport.xlsx';
        RowNo := 1;

        ExcelBuffer.Init();
        ExcelBuffer.DeleteAll(); // Clear any previous data in Excel Buffer

        // Add headers to the Excel file
        AddExcelHeaders(ExcelBuffer);

        // Add data rows from the Users table
        if Users.FindSet() then begin
            repeat
                AddUserRowToExcel(ExcelBuffer, Users, RowNo);
                RowNo := RowNo + 1;
            until Users.Next() = 0;
        end;

        // Create and save Excel content using Excel Buffer
        TempBlob.CreateOutStream(OutStream);

        // Write the Excel data to the sheet
        ExcelBuffer.WriteSheet('Users List', COMPANYNAME, USERID); // Assuming COMPANYNAME and USERID are accessible variables

        // Prepare the InStream for download
        TempBlob.CreateInStream(InStream);

        // Download the generated Excel file
        DownloadFromStream(InStream, '', '', FileName, FileName);

        exit(true);
        // Capture any error during the WriteSheet or Excel operations
        ErrorText := 'An error occurred during Excel export: ';
        exit(false);
    end;

    local procedure AddExcelHeaders(var ExcelBuffer: Record "Excel Buffer")
    begin
        // Add headers to the Excel file
        ExcelBuffer.AddColumn('MemberID', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('FirstName', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('SecondName', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Surname', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Phone_No', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('EmailID', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Gender', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('DOB', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Status', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CreatedAt', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('CreatedBy', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('ModifiedAt', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('ModifiedBy', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure AddUserRowToExcel(var ExcelBuffer: Record "Excel Buffer"; Users: Record Users; RowNo: Integer)
    begin
        // Add user data row to the Excel buffer
        ExcelBuffer.AddColumn(Users."MemberID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Users."firstName", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Users."SecondName", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Users."Surname", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Users."Phone_No", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Users."EmailID", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Users."Gender", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Format(Users."DOB"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(Users."Status", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Format(Users."CreatedAt"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(Users."CreatedBy", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Format(Users."ModifiedAt"), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn(Users."ModifiedBy", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;
}
