@isTest
public class TrackingTriggerHandlerTest {
    @isTest static void testSettingLongitudeLatitude(){
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
        
        Shipping__c shipp = new Shipping__c();
        shipp.Account__c = Acc.Id;
        shipp.Sender__c = cont.Id;
        shipp.Status__c = 'Processing';
        shipp.Delivery_Street__c ='test';
        shipp.Delivery_Postal_Code__c='test';
        shipp.Delivery_City__c='test';
        shipp.Delivery_State__c='test';
        shipp.Delivery_Country__c='test';
        
        insert shipp;
        
        Trac__c trac = new Trac__c();
        trac.Description__c = 'test';
        trac.Shipping__c = shipp.Id;
         
        insert trac;
        
        System.assert(trac.Location__Latitude__s != null && trac.Location__Longitude__s != null);
        
        
    }
}