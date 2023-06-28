//Trigger for listening to "Test Event" events.
trigger testEventTrigger on Test_Event__e(after insert){
    //Keep Trigger cleaned from any logic code, use Handler and Util classes for logic.
    System.debug('testEventTrigger...');
    TriggerDispatcher.run(new testEventTriggerHandler());
}