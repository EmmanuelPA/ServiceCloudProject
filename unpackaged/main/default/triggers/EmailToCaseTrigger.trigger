trigger EmailToCaseTrigger on EmailMessage (before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        EmailToCaseTriggerHandler.getInfoEmail(Trigger.new);
    }
}