/**
* Description :  This Batch class is used to process the Lead records.             
*
* Created By : Shubham Raut
*
* Created Date : 18/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
public class LeadProcessorBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }
    
    public void execute(Database.BatchableContext bc, List<Lead> listOfLead){
        
        List<Lead> listToUpdateLead = new List<Lead>();
        
        if(!listOfLead.isEmpty()){
            
            for(Lead objLead : listOfLead){
                
                Lead updateLead = new Lead();
                updateLead.Id = objLead.Id;
                updateLead.LeadSource = 'Dreamforce';
                
                listToUpdateLead.add(updateLead);
            }
        }
        
        if(!listToUpdateLead.isEmpty())
            Database.update(listToUpdateLead, false);
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
    
}