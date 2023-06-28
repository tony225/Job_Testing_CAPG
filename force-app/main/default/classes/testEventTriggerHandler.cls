/**********************************************************************
Version Author Details
1.0 - Christian Perez 28/06/2023 Initial Development
***********************************************************************/
Public class testEventTriggerHandler implements ITriggerHandler{
    //Use this variable to disable this trigger from transaction
    public static Boolean TriggerDisabled = false;
    
    //Check if the trigger is disabled from transaction
    public Boolean isDisabled(){
        return TriggerDisabled;
    }
    
    public void BeforeInsert(List<SObject> trgNew){
    }
    
    public void AfterInsert(Map<Id, SObject> trgNewMap){
        System.debug('AfterInsert Trigger');
        testEventTriggerHandlerUtils.checkTestEventRisk((List<Test_Event__e>) trgNewMap.values());
    }
    
    public void BeforeUpdate(Map<Id, SObject> trgNewMap, Map<Id, SObject> trgOldMap){
    }
    
    public void AfterUpdate(Map<Id, SObject> trgNewMap, Map<Id, SObject> trgOldMap){
    }
    
    public void BeforeDelete(Map<Id, SObject> trgOldMap){
    }
    
    public void AfterDelete(Map<Id, SObject> trgOldMap){
    }
    
    public void AfterUnDelete(Map<Id, SObject> trgOldMap){
    }    
}