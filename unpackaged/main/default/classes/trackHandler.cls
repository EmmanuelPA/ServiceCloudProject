public with sharing class trackHandler {

    @AuraEnabled
    public static void deleteTrackingRecord(Id recordId ){
        try {
            Trac__c trackToDelete = [SELECT Id FROM Trac__c WHERE Id = :recordId LIMIT 1]; 
            delete trackToDelete;
        } catch (DmlException e) {
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<getWrapper> getTracking(String trackingNumber){
        String searchkey = '%' + trackingNumber + '%';
        List<Trac__c> tracs =  [SELECT Name, Shipping__r.Account__r.Name, Shipping__r.Account__r.RecordType.Name, 
        Shipping__r.Account__r.CustomerPriority__c, Shipping__r.Account__r.Shipments_this_Month__c, status__c  
        FROM Trac__c WHERE Name LIKE: searchkey LIMIT 5];
        List<Case> cases = [SELECT RecordType.Name, Tracking_Number__c FROM Case WHERE Tracking_Number__c != null];
        return wrapTrackingContent(tracs,cases);
    }

    @AuraEnabled(cacheable=true)
    public static List<getWrapper> getAllTracking(String trackingNumber){
        String searchkey = '%' + trackingNumber + '%';
        List<Trac__c> tracs =  [SELECT Name, Shipping__r.Account__r.Name, Shipping__r.Account__r.RecordType.Name, 
        Shipping__r.Account__r.CustomerPriority__c, Shipping__r.Account__r.Shipments_this_Month__c, status__c  
        FROM Trac__c WHERE Name LIKE: searchkey];
        List<Case> cases = [SELECT RecordType.Name, Tracking_Number__c FROM Case WHERE Tracking_Number__c != null];
        return wrapTrackingContent(tracs,cases);
    }

    private static List<getWrapper> wrapTrackingContent(List<Trac__c> tracs, List<Case> cases){
        Map<Id, Case> casesMapped = new Map<Id, Case>();
        for(Case thiscase : cases){
            casesMapped.put(thiscase.Tracking_Number__c, thiscase);
        }
        List<getWrapper> wrapperList = new List<getWrapper>();
        for(Trac__c trac: tracs){
            getWrapper wrapper = new getWrapper();
            wrapper.Id = trac.Id;
            wrapper.trackingNumber = trac.Name;
            wrapper.customerName = trac.Shipping__r.Account__r.Name;
            wrapper.customerType = trac.Shipping__r.Account__r.RecordType.Name;
            if(casesMapped.containsKey(trac.Id)){
                wrapper.caseType = casesMapped.get(trac.Id).RecordType.Name;
            }
            wrapper.customerPriority = trac.Shipping__r.Account__r.CustomerPriority__c;
            wrapper.shipmentsThisMonth = Integer.valueOf(trac.Shipping__r.Account__r.Shipments_this_Month__c);
            wrapper.status = trac.status__c;
            wrapperList.add(wrapper);
        }
        return wrapperList;
    }

    public class getWrapper {
        @AuraEnabled public Id Id;
        @AuraEnabled public String trackingNumber;
        @AuraEnabled public String customerName;
        @AuraEnabled public String customerType;
        @AuraEnabled public String caseType;
        @AuraEnabled public String customerPriority;
        @AuraEnabled public Integer shipmentsThisMonth; 
        @AuraEnabled public String status;
    }
}