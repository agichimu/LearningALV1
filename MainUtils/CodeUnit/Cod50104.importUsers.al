namespace LearningAl.LearningAl;

codeunit 50104 importUsers
{
    TableNo = Users;
    
   trigger OnRun()
    var
        UsersImport: XmlPort "usersImport";
    begin
        UsersImport.Import();
    end;
    
}