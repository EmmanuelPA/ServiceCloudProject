public without sharing class TrackingTriggerHandler {
    public static void updateLocation(List<Trac__c> trackingList){
        for( Trac__c tr: trackingList){
            tr.Location__Latitude__s = getRandomNumberHelperMethod()[0];
            tr.Location__Longitude__s = getRandomNumberHelperMethod()[1];
        }
   }
   public static List<Double> getRandomNumberHelperMethod(){
       // some places near by Queretaro
       double latitude = 20.60384;
       double longitude = -100.12939;
       double radius = 0.1; 
       Decimal Lat = latitude+Math.random() * radius * 5 - radius;
       Decimal Lon = longitude+Math.random() * radius * 5 - radius;
       Double [] values = new List<Double>();
       values.add(Lat.setscale(6).doubleValue());
       values.add(Lon.setscale(6).doubleValue());
       return values;
   }
}