/**********************************************************************
Version Author Details
1.0 - Christian Perez 28/06/2023 Initial Development
***********************************************************************/
Public Interface ITriggerHandler{
    void BeforeInsert(List<SObject> trgNew);
    void BeforeUpdate(Map<Id, SObject> trgNewMap, Map<Id, SObject> trgOldMap);
    void BeforeDelete(Map<Id, SObject> trgOldMap);
    void AfterInsert(Map<Id, SObject> trgNewMap);
    void AfterUpdate(Map<Id, SObject> trgNewMap, Map<Id, SObject> trgOldMap);
    void AfterDelete(Map<Id, SObject> trgOldMap);
    void AfterUndelete(Map<Id, SObject> trgOldMap);
    Boolean IsDisabled();
}