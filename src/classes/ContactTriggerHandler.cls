/**
* Description : It Contains Contact Trigger Handler Methods              
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
        populateObjectAndPicklistOnContact(newListOfContact);
        
    }
    
    public override void beforeUpdate() {
        checkConEmailDomainWithAcc(newListOfContact, oldMapOfContact);
        populateObjectAndPicklistOnContact(newListOfContact);
        
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
                
                if(objCon.AccountId != null && !String.isEmpty(objCon.Email)){
                    
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
  
    
    /**
    *
    * @description : will populate the name of the entered Record Id Object Name in Object_Name__c And 
    *                Also store all the picklist field name with line break in Picklist_Field__c On Contact.
    *
    * @args : listOfContact (new or old).
    *
    * @return : void
    *
    * @revision Log : V1.1 - Created - 27/12/24 - Shubham Raut
    *
    **/
    public static void populateObjectAndPicklistOnContact(List<Contact> conList)
    {
        if(!conList.isEmpty())
        {
            for(Contact con : conList)
            {
                if(!String.isEmpty(con.RecordID__c)) 
                { 
                    try{
                        //Will check if Record Id is Valid Or Not
                        if(Id.valueOf(con.RecordID__c) != null)
                        {
                            List<string> listOfPicklistfields = new List<string>();
                            
                            Id recordId = (Id) con.RecordID__c;
                            
                            SobjectType SObjectName = recordId.getSObjectType();
                            
                            Schema.DescribeSObjectResult sObjectDescribe = SObjectName.getDescribe(); 
                            
                            if(sObjectDescribe != null){
                                //Will retrieve Picklist Field Names and Store in List
                                for (Schema.SObjectField field : sObjectDescribe.fields.getMap().values()) 
                                { 
                                    Schema.DescribeFieldResult fieldDescribe = field.getDescribe(); 
                                    
                                    if (fieldDescribe.getType() == Schema.DisplayType.Picklist) 
                                    { 
                                        listOfPicklistfields.add(fieldDescribe.getName());
                                    } 
                                }
                            }
                            
                            //Will Populate Object Name on Rec
                            con.Object_Name__c = sObjectDescribe.getName();
                            
                            //Will Populate Picklist Field Names on Rec
                            if(!listOfPicklistfields.isEmpty())
                            {
                                con.Picklist_Fields__c = '';
                                
                                for(String str : listOfPicklistfields)
                                {
                                    con.Picklist_Fields__c += str + '\n';       
                                }
                            } 
                            else{
                                con.Picklist_Fields__c = '';
                            }
                        }
                    }catch(Exception e){
                        
                        con.addError('Entered Record Id is Invalid!');
                    }
                }
            }
        }
    }  
}