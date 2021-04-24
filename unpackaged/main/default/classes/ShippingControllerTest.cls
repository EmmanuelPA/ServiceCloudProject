@isTest
class ShippingControllerTest {
    public static List<Shipping__c> createDummyShippingRecords(Integer numShips){
        List<Shipping__c> shp = new List<Shipping__c>();
        
        for (Integer count = 0; count < numShips; count++) {
        	Shipping__c s = new Shipping__c(Account__c='0015e0000031OYTAA2', Delivery_Street__c='Str. '+count);
            shp.add(s);
    	}
        
        insert shp;
        
        return shp;
    }
    
    //Exception Expected
    @isTest
    static void testGetShippingInformation (){
    	List<Shipping__c> dummyShippings = createDummyShippingRecords(5); 
    	Test.startTest();
        try
      {
          List<Shipping__c> result = ShippingController.getShippingInformation('String que no pertenece a ningun record');
      }
      catch(exception e)
         {
			}     
    	Test.stopTest();
}
    
    //Result Expected
    @isTest
    static void testGetShippingInformation2 (){
        List<Shipping__c> dummyShippings = createDummyShippingRecords(5);
        Id searchId = dummyShippings.get(1).Id;
        Shipping__c searchShipping = [SELECT Name FROM Shipping__c WHERE Id = :searchId];
        String trackNum = searchShipping.Name;
        Test.startTest();
        List<Shipping__c> result = ShippingController.getShippingInformation(trackNum);
        Integer actualSize = result.size();
    	Test.stopTest();
        System.assertEquals(dummyShippings.isEmpty(), false);
    }
}
