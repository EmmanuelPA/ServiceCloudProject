public without sharing class ContactController {
	@AuraEnabled(cacheable=true)
    public static Contact getContactByEmail(String email){
        return [SELECT Id, Name, Email, LastName, Account.Id, Account.Name, Account.RecordTypeId FROM Contact WHERE Email = :email WITH SECURITY_ENFORCED LIMIT 1];
    }
    
    
}