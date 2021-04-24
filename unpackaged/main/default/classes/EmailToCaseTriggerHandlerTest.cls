@isTest
public class EmailToCaseTriggerHandlerTest {
    static testMethod void testEmailBusinessAccount(){
        Account Acc = new Account();
        Acc.Name='Account Business Low';
        Acc.CustomerPriority__c='Low';
        Acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Business Account').getRecordTypeId();
        
        insert Acc;
        
        Contact cont = new Contact();
        cont.Salutation='Mr';
        cont.LastName='Test';
        cont.AccountId = Acc.Id;
        cont.Email = 'Test_Test@gmail.com';
        
        insert cont;
         
     
        EmailMessage e = new EmailMessage();
        e.FromAddress = 'Test_Test@gmail.com';
        e.Subject = 'Help';
        e.TextBody = 'my tracking number is S2104210016';
        e.ToAddress = 'universallogisticenterprise@gmail.com';
       	
        insert e;
        
        Case caseTest = [SELECT  Id, CaseNumber FROM Case WHERE SuppliedEmail = 'Test_Test@gmail.com' ];
        
    } 	
}