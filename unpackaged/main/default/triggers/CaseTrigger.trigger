trigger CaseTrigger on Case (after insert) {
    CaseFireAssignment.fireAssignment((List<Case>)trigger.new);
}