/**
 * Description : It Contains Attendee Triggers Related Logic Methods
 *               (Attendee is Child of Contact And Training Session)
 *
 * Created By : Shubham Raut
 *
 * Created Date : 10/12/24
 *
 * Revision Logs : V1.0 - Created - Shubham Raut
 *
 *
 **/
public class AttendeeTriggerHandler extends TriggerHandler{
    
    List<Attendee__c> newListOfAttendee ;
    List<Attendee__c> oldListOfAttendee;
    Map<Id, Attendee__c> newMapOfAttendee;
    Map<Id, Attendee__c> oldMapOfAttendee;
    
    public AttendeeTriggerHandler(){
        
        newListOfAttendee = (List<Attendee__c>) Trigger.new;
        oldListOfAttendee = (List<Attendee__c>) Trigger.old;
        newMapOfAttendee = (Map<Id, Attendee__c>) Trigger.newMap;
        oldMapOfAttendee = (Map<Id, Attendee__c>) Trigger.oldMap;
        
        //this.setMaxLoopCount(1);
    }
    
    public override void beforeInsert() {
            				
    }
    
    public override void beforeUpdate() {
        				
    }
    
    public override void beforeDelete() {
        				
    }
    
    public override void afterInsert() {    
        
        countOfTrainingSessions(newListOfAttendee, oldMapOfAttendee, newMapOfAttendee);
    }
    
    public override void afterUpdate() {
        
        countOfTrainingSessions(newListOfAttendee, oldMapOfAttendee, newMapOfAttendee);
    }
    
    public override void afterDelete() {
       
        countOfTrainingSessions(oldListOfAttendee, oldMapOfAttendee, newMapOfAttendee);
    }
    
    public override void afterUndelete() {
      
        countOfTrainingSessions(newListOfAttendee, oldMapOfAttendee, newMapOfAttendee);
    }

    
    /**
     *
     * @description : To Count Training Sessions which is associated to Contact through Attendee 
     *                (Attendee is Child of Contact And Training Session)
     *
     * @args : listOfAttendee (new or old) , newMapOfAttendee , oldMapOfAttendee.
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 10/12/24 - Shubham Raut
     *
     **/
    public static void countOfTrainingSessions(List<Attendee__c> listOfAttendee, Map<Id, Attendee__c> oldMapOfAttendee, Map<Id, Attendee__c> newMapOfAttendee)
    {
        
        Set<Id> setOfIds = new Set<Id>();
        
        for(Attendee__c objAtt : listOfAttendee)
        {
            
            if(objAtt.Contact__c != null )
            {
                setOfIds.add(objAtt.Contact__c);
            }
            
            if(oldMapOfAttendee !=null && oldMapOfAttendee.get(objAtt.Id).Contact__c != null && 
               (objAtt.Contact__c != oldMapOfAttendee.get(objAtt.Id).Contact__c))
            {  
                setOfIds.add(oldMapOfAttendee.get(objAtt.Id).Contact__c);
            }         
        }
        
        
        system.debug(setOfIds);
        
        Map<Id ,Set<Id>>  mapOfContactIdsWithRelatedSessionIds = new Map<Id, Set<Id>>();
        
        if(!setOfIds.isEmpty())
        {
            
            for(Attendee__c objAtt : [Select Id , Contact__c , Session__c from Attendee__c where Contact__c IN : setOfIds])
            {
                if(!mapOfContactIdsWithRelatedSessionIds.containsKey(objAtt.Contact__c))
                {
                    mapOfContactIdsWithRelatedSessionIds.put(objAtt.Contact__c , new Set<Id>());
                }
                
                if(mapOfContactIdsWithRelatedSessionIds.containsKey(objAtt.Contact__c))
                {
                    mapOfContactIdsWithRelatedSessionIds.get(objAtt.Contact__c).add(objAtt.Session__c);
                }
            }
        }
        
        List<Contact> listOfContact = new List<Contact>();      
        
        for(Id conId : setOfIds)
        {
            listOfContact.add(new Contact(Id = conId , 
                                          No_of_Sessions__c = mapOfContactIdsWithRelatedSessionIds.containsKey(conId) ? 
                                          mapOfContactIdsWithRelatedSessionIds.get(conId).size() : 0));        
        }       
        
        system.debug(listOfContact);
        
        if(!listOfContact.isEmpty())
            update listOfContact;      
    }
}