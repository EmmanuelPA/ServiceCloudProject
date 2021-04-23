public class CaseFireAssignment {
    public static void fireAssignment(List<Case> cases) {
        fireAssignment(JSON.serialize(cases));
    }
    
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