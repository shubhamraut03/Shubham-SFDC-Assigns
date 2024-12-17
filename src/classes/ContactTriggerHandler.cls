/**
 * Description : It Contains Contact Triggers Related Logic Methods
 *               (Contact is child of Account)
 *
 * Created By : Shubham Raut
 *
 * Created Date : 4/12/24
 *
 * Revision Logs : V1.0 - Created - Shubham Raut
 *
 *
 **/
public class ContactTriggerHandler extends TriggerHandler{
    
    List<Contact> newListOfContact ;
    List<Contact> oldListOfContact;
    Map<Id, Contact> newMapOfContact;
    Map<Id, Contact> oldMapOfContact;
    
    public ContactTriggerHandler(){
        newListOfContact = (List<Contact>) Trigger.new;
        oldListOfContact = (List<Contact>) Trigger.old;
        newMapOfContact = (Map<Id, Contact>) Trigger.newMap;
        oldMapOfContact = (Map<Id, Contact>) Trigger.oldMap;
    }
    
    public override void beforeInsert() {
        checkConEmailDomainWithAcc(newListOfContact, oldMapOfContact);
        
    }
    
    public override void beforeUpdate() {
        checkConEmailDomainWithAcc(newListOfContact, oldMapOfContact);
        
    }
    
    public override void beforeDelete() {
        
    }
    
    public override void afterInsert() {    
        
    }
    
    public override void afterUpdate() {
        
    }
    
    public override void afterDelete() {
        
    }
    
    public override void afterUndelete() {
        
    }
    
    
    /**
     *
     * @description : To Check Contact Email Domain With Associated Account
     *
     * @args : listOfContact (new or old) , oldMapOfContact.
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 4/12/24 - Shubham Raut
     *
     **/
    public static void checkConEmailDomainWithAcc(List<Contact> listOfContact, Map<Id, Contact> oldMapOfContact){
        
        Set<Id> accSet = new Set<Id>();
        
        if(!listOfContact.isEmpty()){
            
            for(Contact objCon : listOfContact){
                
                if(objCon.AccountId != null && String.isNotEmpty(objCon.Email)){
                        
                        accSet.add(objCon.AccountId); 
                }
            }
        }
        
        
        if(!accSet.isEmpty()){
            
            Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id, Domain__c FROM Account WHERE Id IN :accSet]);
            
            for(Contact objCon : listOfContact){
                
                if(!objCon.Email.endsWith(accMap.get(objCon.AccountId).Domain__c)){
                    
                    objCon.Email.addError('Email does not contain Account Domain!');
                }
            }
        }
    }    
}