public without sharing class ShippingController {
    @AuraEnabled(cacheable=true)
    public static List<Shipping__c> getShippingInformation(String trackingNumber) {
        List<Shipping__c> shippingInfo = new List<Shipping__c>();
        shippingInfo = [SELECT Id, Name, Return_City__c, Return_Country__c, Delivery_City__c, Delivery_Country__c, Status__c FROM Shipping__c WHERE Name = :trackingNumber];
    
        if(shippingInfo.size() == 0){
            throw new AuraHandledException('No Record Found.'); 
        }
    
        return shippingInfo;
    }
}