Public class Publish_Event{
    Public static void publish(String risk){
        Test_Event__e newsEvent = new Test_Event__e();
        newsEvent.Risk__c = risk;
        //Call method to publish events
        Database.SaveResult sr = EventBus.publish(newsEvent);
        //Inspect publishing result
        if(sr.isSuccess()){
            System.debug('Successfully published event.');
        } else {
            for(Database.Error err : sr.getErrors()) {
                System.debug('Error returned: ' + err.getStatusCode() + ' - ' + err.getMessage());
            }
        }
    }
}