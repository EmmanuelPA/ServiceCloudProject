@isTest
public class CaseFireAssignmentTest {
	@isTest
    public static void fireAssignmentTest(){
        List<Case> listOfCases = new List<Case>();
        Contact contact = new Contact(LastName = 'Emma');
        Case caseToList = new Case(ContactId = contact.Id,
            					   Subject = 'S123231312',
            					   Origin = 'Web');
        insert caseToList;
        listOfCases.add(caseToList);
        JSON.serialize(listOfCases);
        
        Test.startTest();
        CaseFireAssignment.fireAssignment(listOfCases);
    	Test.stopTest();
        
        Case caseToCompare = [SELECT Id, ContactId, Origin FROM Case WHERE ContactId = :contact.Id];
        System.assertEquals(caseToList.Id, caseToCompare.Id);
        
    } 
        
}