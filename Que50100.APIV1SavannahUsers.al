namespace LearningAl.LearningAl;

query 50100 "APIV1 - Savannah  Users"
{
    APIGroup = 'api';
    APIPublisher = 'savannahventures';
    APIVersion = 'v1.0';
    EntityName = 'savannahUser';
    EntitySetName = 'savannahUsers';
    QueryType = API;

    elements
    {
        dataitem(users; Users)
        {
            column(memberID; MemberID)
            {
                Caption = 'memberID', Locked = true;
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
            column(phoneNo; Phone_No)
            {
            }
            column(emailID; emailID)
            {
            }
            column(gender; gender)
            {
            }
            column(dob; DOB)
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
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
