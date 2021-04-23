public without sharing class TrackingLocationController {
    @AuraEnabled(Cacheable=true)
    public static Trac__c[] getAllTracks( String search){
        return [
            SELECT
                Name,
                Location__Latitude__s,
                Location__Longitude__s
                FROM Trac__c
                WHERE Shipping__r.Name =: search
                ORDER BY Name
                LIMIT 50
        ];
    } 
}