public with sharing class TrackingController {
    @AuraEnabled(cacheable=true)
    public static List<Trac__c> getTrackingInformation(String trackingNumber) {
        List<Trac__c> trackingInfo = new List<Trac__c>();
        trackingInfo = [SELECT Id, City__c, Country_Code__c, Description__c FROM Trac__c WHERE Shipping__r.Name =: trackingNumber ORDER BY CreatedDate DESC];
    
        return trackingInfo;
    }
}