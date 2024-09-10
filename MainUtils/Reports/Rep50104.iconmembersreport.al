namespace LearningAl.LearningAl;
using Microsoft.Foundation.Company;

report 50104 "iconmembers report"
{
    ApplicationArea = All;
    Caption = 'iconmembers report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './LearningAl/members.rdl';

    dataset
    {
        dataitem(Users; Users)
        {
            column(CompanyInformation_Picture; CompanyInformation.Picture)
            {

            }
            column(CompanyName; CompanyName)
            {

            }
            column(BuldingName; BuldingName)
            {
            }
            column(CompanyAddress; CompanyAddress)
            {
            }
            column(CompanyTelephone; CompanyTelephone)
            {
            }
            column(CompanyEmail; CompanyEmail)
            {
            }
            column(PrintingDate; PrintingDate)
            {

            }
            column(PrintingTime; PrintingTime)
            {

            }
            column(PrintedBy; PrintedBy)
            {

            }
            column(MemberID; MemberID)
            {
            }
            column(firstName; firstName)
            {
            }
            column(secondName; secondName)
            {
            }
            column(surname; surname)
            {
            }
            column(Phone_No; Phone_No)
            {
            }
            column(emailID; emailID)
            {
            }
            column(gender; gender)
            {
            }
            column(DOB; DOB)
            {
            }
            column(status; status)
            {
            }
            column(createdAt; createdAt)
            {
            }
            column(createdBy; createdBy)
            {
            }
            column(modifiedAt; modifiedAt)
            {
            }
            column(modifiedBy; modifiedBy)
            {
            }
            column(Age; CalculateAge(DOB))
            {
            }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        if CompanyInformation.Get then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
            CompanyName := CompanyInformation.Name;
            //BuldingName := CompanyInformation."Building Name";
            CompanyAddress := CompanyInformation.Address + ' -Post Code: ' + CompanyInformation."Post Code" + ' -City:' + CompanyInformation.City + ' Region: ' + CompanyInformation."Country/Region Code";
            CompanyTelephone := CompanyInformation."Phone No." + ',' + CompanyInformation."Phone No. 2";
            CompanyEmail := CompanyInformation."E-Mail";
            //PrintingDate := GlobalFunctions.DMUDateFormatDate(Today);
            PrintingTime := Format(Time);
            //PrintedBy := GlobalFunctions.FormatUserName(UserId);

        end;

    end;

    var
    
    // Date2DMY Function:
    // The Date2DMY function extracts the day, month, or year from a given date. It takes two arguments:
    // 1 for day,
    // 2 for month,
    // 3 for year.

    local procedure CalculateAge(DOB: Date): Integer
    var
        CurrentDate: Date;
        Age: Integer;
    begin
        CurrentDate := Today(); // Get today's date

        if DOB <> 0D then begin
            Age := Date2DMY(CurrentDate, 3) - Date2DMY(DOB, 3);
            //current month before dob
            if (Date2DMY(CurrentDate, 2) < Date2DMY(DOB, 2)) or
               //currrent month same as dob
               ((Date2DMY(CurrentDate, 2) = Date2DMY(DOB, 2)) and
               //current day is before the birthday
               (Date2DMY(CurrentDate, 1) < Date2DMY(DOB, 1))) then begin
                Age := Age - 1;
            end;
        end else
            Age := 0;

        exit(Age);
    end;

    var
        CompanyName: Text;
        BuldingName: Text;
        CompanyAddress: Text;
        CompanyTelephone: Text;
        CompanyEmail: Text;
        PrintingDate: Text;
        PrintingTime: Text;
        PrintedBy: Code[50];



        CompanyInformation: Record "Company Information";
    //GlobalFunctions: Codeunit "Global Functions";


}
