/**
* @author Jose Pech
* @date 21 04 2021
*
* @description Contact Controller on Contacts that retrieve Contact and Account information in order to giving the correct
* information to the WebToCase component
*/
public without sharing class ContactController {
    /*******************************************************************************************************
    * @description Returns Contact fields
    * @param Email the email of the contact you want to retrieve his data
    * @return the contact object with the correct properties for the lwc component
    * @example
    * Contact a = new Contact();
    */
	@AuraEnabled(cacheable=true)
    public static Contact getContactByEmail(String email){
        return [SELECT Id, Name, Email, LastName, Account.Id, Account.Name, Account.RecordTypeId FROM Contact WHERE Email = :email WITH SECURITY_ENFORCED LIMIT 1];
    }
    
    
}