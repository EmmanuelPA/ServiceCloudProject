trigger TrackingTrigger on Trac__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        TrackingTriggerHandler.updateLocation(Trigger.new);
    }
}