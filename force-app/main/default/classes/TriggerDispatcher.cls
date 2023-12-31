/**********************************************************************
Version Author Details
1.0 - Christian Perez 28/06/2023 Initial Development
***********************************************************************/
Public class TriggerDispatcher{
    Public static void Run(ITriggerHandler handler){
        //Check to see if the trigger has been disabled. If it has, return
        if(handler.IsDisabled()) return;
        
        //Detect the current trigger context and fire the relevant methods
        //Before trigger logic ****************************************/
        if(Trigger.IsBefore){
            if(Trigger.IsInsert)
                handler.BeforeInsert(trigger.new);
            if(Trigger.IsUpdate)
                handler.BeforeUpdate(trigger.newMap, trigger.oldMap);
            if(Trigger.IsDelete)
                handler.BeforeDelete(trigger.oldMap);
        }
        //After trigger logic *****************************************/
        if(Trigger.IsAfter){
            if(Trigger.IsInsert)
                handler.AfterInsert(Trigger.newMap);
            if(Trigger.IsUpdate)
                handler.AfterUpdate(trigger.newMap, trigger.oldMap);
            if(trigger.IsDelete)
                handler.AfterDelete(trigger.oldMap);
            if(trigger.isUndelete)
                handler.AfterUndelete(trigger.oldMap);
        }
    }
}