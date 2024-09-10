namespace ALProject.ALProject;

using LearningAl.LearningAl;

page 50100 UsersList
{
    ApplicationArea = All;
    Caption = 'UsersList';
    PageType = List;
    SourceTable = Users;
    UsageCategory = Lists;
    InsertAllowed = true;
    SaveValues = true;
    // Linking List to UsersList to card
    CardPageId = UsersCard;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("MemberID"; Rec."MemberID")
                {
                    ToolTip = 'Specifies the value of the MemberID field.', Comment = '%';
                    Editable = false;
                }
                field(firstName; Rec.firstName)
                {
                    ToolTip = 'Specifies the value of the firstName field.', Comment = '%';
                }
                field(SecondName; Rec.SecondName)
                {
                    ToolTip = 'Specifies the value of the SecondName field.', Comment = '%';
                }
                field(Surname; Rec.Surname)
                {
                    ToolTip = 'Specifies the value of the Surname field.', Comment = '%';
                }
                field(Phone_No; Rec.Phone_No)
                {
                    ToolTip = 'Specifies the value of the Phone_No field.', Comment = '%';
                }
                field(EmailID; Rec.EmailID)
                {
                    ToolTip = 'Specifies the value of the EmailID field.', Comment = '%';
                }
                field(Gender; Rec.Gender)
                {
                    ToolTip = 'Specifies the value of the Gender field.', Comment = '%';
                }
                field(DOB; Rec.DOB)
                {
                    ToolTip = 'Specifies the value of the DOB field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';

                }
                field(CreatedAt; Rec.CreatedAt)
                {
                    ToolTip = 'Specifies the value of the CreatedAt field.', Comment = '%';
                }
                field(CreatedBy; Rec.CreatedBy)
                {
                    ToolTip = 'Specifies the value of the CreatedBy field.', Comment = '%';
                }
                field(ModifiedAt; Rec.ModifiedAt)
                {
                    ToolTip = 'specifies the value of theModifiedAt', Comment = '%';
                }
                field(ModifiedBy; Rec.ModifiedBy)
                {
                    ToolTip = 'spcifies the value of ModifiedBy', Comment = '%';
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(importUsers)
            {
                action("Import Users")
                {
                    Caption = 'Import Users';
                    ApplicationArea = Basic;
                    Image = Import;
                    trigger OnAction()

                    begin
                        Xmlport.Run(50103, false, true);
                    end;
                }
            }
            group(exportToExcel)
            {
                action("Export to Excel")
                {
                    Caption = 'Open In Excel';
                    ApplicationArea = All;
                    Image = Export;
                    trigger OnAction()
                    var
                        ExportTestCodeunit: Codeunit 50105;
                        IsHandled: Boolean;
                        ErrorText: Text;
                    begin
                        IsHandled := ExportTestCodeunit.ExportUsersToExcel(ErrorText);
                        if IsHandled then
                            Message('Export completed successfully!')
                        else
                            Message('Export failed: %1', ErrorText);
                    end;
                }

            }
            group(sowreport)
            {
                action(ShowReport)
                {
                    ApplicationArea = All;
                    Caption = 'Show User Report';
                    Image = Report;
                    trigger OnAction()
                    var
                        Report: Report "iconmembers report";
                    begin
                        Report.RunModal();
                    end;
                }

            }
        }
        area(Promoted)
        {
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
            }
            group(Category_Category4)
            {
                Caption = 'Functions', Comment = 'Generated from the PromotedActionCategories property index 3.';
            }
            group(Category_Category5)
            {
                Caption = 'Job', Comment = 'Generated from the PromotedActionCategories property index 4.';
            }
            group(Category_Category6)
            {
                Caption = 'Import Users', Comment = 'Generated from the PromotedActionCategories property index 5.';

                actionref("Import Users_Promoted"; "Import Users")
                {
                }
            }
            group(Category_Category7)
            {
                Caption = 'Export To Excel', Comment = 'Generated from the PromotedActionCategories property index6.';

                actionref("export to excel_Promoted"; "Export To Excel")
                {
                }
            }

            group(Category_Category8)
            {
                Caption = 'Show User Report', Comment = 'Generated from the PromotedActionCategories property index7.';

                actionref("Show User Report"; "ShowReport")
                {
                }
            }
        }
    }

}

