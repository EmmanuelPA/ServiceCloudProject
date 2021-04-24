/**
* @author Jose Pech
* @date 21 04 2021
*
* @description Trigger on Case that fires the CaseFireAssignment method
*/
trigger CaseTrigger on Case (after insert) {
    CaseFireAssignment.fireAssignment((List<Case>)trigger.new);
}