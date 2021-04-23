public class EmailToCaseTriggerHandler {
    public static void getInfoEmail(List<EmailMessage> emails){
        
        String address, body, idEmail, Searchvalue, idAcc, track;
        Contact obj;
        Case objCase;
        List<Contact> contactAcc;
        List<Case> listofCases;
        
        for(EmailMessage e: emails){
             address = e.FromAddress;
             body = e.TextBody;
             idEmail = e.CreatedById;
             Searchvalue = '%' + address + '%';     
        }
        contactAcc = [SELECT AccountId FROM Contact WHERE Email LIKE :Searchvalue LIMIT 1]; 
        
         for(Contact c : contactAcc){  
              idAcc = c.AccountId;                     
          }
         obj = [SELECT Id, AccountId, Account.RecordType.Name, Account.CustomerPriority__c
      		    FROM Contact
                WHERE AccountId =: idAcc ];
        
        //regex
        Pattern MyPattern = Pattern.compile('.*(\\S[0-9]{2}(0[0-9]{1})|(1[0-2]{1})[0-9]{6}}).*');
        Matcher MyMatcher = MyPattern.matcher(body);
        if(MyMatcher.matches()){
			 track = MyMatcher.group(1);           
            System.debug('Si encontro el shipping:  '+track);
        }
        else {
            System.debug('No hay tracknumber');
        }
        
         listofCases = [SELECT Id, SuppliedEmail, Priority, SuppliedName, CaseNumber, Tracking_Number__r.Name,ContactId, AccountId
                        FROM Case Where SuppliedEmail =: address ORDER BY CreatedDate DESC LIMIT 1];
         
        
        
         objCase = listofCases.get(listofCases.size() - 1);
         objCase.AccountId = idAcc;
         objCase.ContactId = obj.Id;
         objCase.Priority = obj.Account.CustomerPriority__c;
        
            //set tracking number
        if(!String.isBlank(track)){
         Shipping__c auxShipp = [SELECT Id, Name FROM Shipping__c WHERE Name =: track];   
         objCase.Tracking_Number__c = auxShipp.Id;
        }
         update objCase;
        
    }
    /*
     * 
     * 	system.debug('ID: ' +obj.AccountId);
					system.debug('Record Type: ' +obj.Account.RecordType.Name);
					system.debug('Customer Priority: ' +obj.Account.CustomerPriority__c);
	*/
}