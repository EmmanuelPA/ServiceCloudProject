public class CaseController {
		@AuraEnabled(cacheable=true)
        public static List<Case> getCasesList(){
            return [SELECT Id, CaseNumber, Subject, Account.Name, Contact.Name, Origin, Tracking_Number__c FROM Case];
        }
}