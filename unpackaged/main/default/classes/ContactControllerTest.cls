@isTest
public class ContactControllerTest {
    @isTest
	public static void getEmailByContactTest(){
        Contact contactToTest = new Contact(LastName = 'Pech',
                                           	Email = 'emmanuel.pecha@gmail.com'
                                           );
        insert contactToTest;
        String email = 'emmanuel.pecha@gmail.com';
        
        Test.startTest();
        	ContactController.getContactByEmail(email);
        Test.stopTest();
        
        Contact contactLocated = [SELECT Id, LastName, Email FROM Contact WHERE Email=:email]; 
        System.assertEquals(email, contactLocated.Email);
    }
        
}