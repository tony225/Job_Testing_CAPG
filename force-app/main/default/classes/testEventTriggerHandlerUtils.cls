/**********************************************************************
Version Author Details
1.0 - Christian Perez 28/06/2023 Initial Development
***********************************************************************/
Public class testEventTriggerHandlerUtils{
    //Method to check Events and create Case record if Risk value is High
    Public static void checkTestEventRisk(List<Test_Event__e> events){
        try{
            //List of cases to be created
            List<Case> cases = new List<Case>();
            //Get queue Id for case owner
            Group queue = [SELECT Id FROM Group WHERE Name = 'Test Group' AND Type = 'Queue'];
            //Iterate through each notification.
            for(Test_Event__e event : events){
                if(event.Risk__c == 'High'){//Create Case if Risk value is High
                    Case cs = new Case();
                    cs.Priority = 'High';
                    cs.Subject = 'Case for Test_Event__e event ' + System.now().formatGMT('MM/dd/YYYY');
                    cs.OwnerId = queue.Id;
                    cases.add(cs);
                }
            }
            //Insert cases
            System.debug('Cases to insert --> ' + cases.size());
            insert cases;
        } catch(exception e){
            system.debug(e.getMessage() + ' Line: ' + e.getLineNumber());
        }
    }
}