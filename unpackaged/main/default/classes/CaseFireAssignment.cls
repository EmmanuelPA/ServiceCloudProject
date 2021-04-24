/**
* @author Jose Pech
* @date 21 04 2021
*
* @description CaseFireAssignment that handles the trigger with after insert param. 
*/
public class CaseFireAssignment {
    public static void fireAssignment(List<Case> cases) {
        fireAssignment(JSON.serialize(cases));
    }
    
    /*******************************************************************************************************
    * @description set the escalation rules for the incoming web cases
    */
    @future
    public static void fireAssignment(String caseJson) {
        List<Case> cases = (List<Case>)JSON.deserialize(caseJson, List<Case>.class);
        List<Case> casesToTouch = new List<Case>();
        for (Case c: cases) {
            if (c.Origin == 'Web') {
                casesToTouch.add(c);
            }
        }
        if (casesToTouch.size() > 0) {
            Database.DMLOptions dmo = new Database.DMLOptions();
            dmo.assignmentRuleHeader.useDefaultRule= true;      
            Database.update(casesToTouch, dmo);
        }
    }
}