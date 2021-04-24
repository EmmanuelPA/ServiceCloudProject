/**
* @author Jose Pech
* @date 21 04 2021
*
* @description Test for ContactController class that  retrieve a contact filtering by email
*/
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