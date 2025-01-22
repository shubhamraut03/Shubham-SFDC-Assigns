//Write down a generic batch, which will run every month. It should archive the data of the given object and period. 
//I Archive, send email User, which will have CSV Data attached in the email. and then delete the records from Salesforce
/**
* Description : This Batch will archive the data of the given object and period. And Send email To User, 
*               which will have CSV Data attached in the email. and then delete the records from Salesforce.
*
* Created By : Shubham Raut
*
* Created Date : 02/01/25
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
public class GenericSObjectBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    @testVisible private static Integer emailInvocations;
    private String csvData = '';
    private String csvFieldsData = '';
    private Set<String> objectFields;
    private List<SObject> recordsToArchive = new List<SObject>();
    private Archive_Config__mdt objMdt;
    
    public GenericSObjectBatch(){
        
        objMdt = Archive_Config__mdt.getInstance('Account_Info');
        
        String objectApiName = objMdt.Object_API_Name__c;
        SObject sObjectInstance = (SObject)Type.forName('Schema.' + objectApiName).newInstance();
        SObjectType sObjectName = sObjectInstance.getSObjectType();
        Schema.DescribeSObjectResult sObjectDescribe = sObjectName.getDescribe();
        
        objectFields = sObjectDescribe.fields.getMap().keySet();
        
        for (String field : objectFields) {
            csvFieldsData += field +',';
        }
        
        if (csvFieldsData.endsWith(',')) {
            csvFieldsData = csvFieldsData.substring(0, csvFieldsData.length() - 1);
        }
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        
        String query;
        
        if(objMdt != null){
            query = 'SELECT '+csvFieldsData+' FROM ' + objMdt.Object_API_Name__c + ' WHERE ' 
                + objMdt.Filter__c + ' AND CreatedDate = ' + objMdt.Duration__c;  
        }
        
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> listOfSObject){
        
        if(!listOfSObject.isEmpty()){
            
            recordsToArchive.addAll(listOfSObject); 
            
            if(!objectFields.isEmpty()){
                
                if(String.isBlank(csvData)){
                    csvData = csvFieldsData;
                    csvData += '\n';
                }
                
                for (sObject record : listOfSObject) {
                    
                    for (String field1 : objectFields) {
                        
                        csvData += record.get(field1) +',';
                    }
                    csvData += '\n';
                }
            }
        }
    }
    
    public void finish(Database.BatchableContext BC) {
        
        if (csvData != null) {
            
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName('ArchivedData.csv');
            attachment.setBody(Blob.valueOf(csvData));
            attachment.setContentType('text/csv');
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] { 'devrautshubham@gmail.com' });
            email.setSubject('Archived Data Of '+objMdt.Object_Label__c+' Object');
            email.setPlainTextBody('Please find the archived data attached.');
            email.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment });
            
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            System.debug('Email sent successfully.');
        }
        
        emailInvocations = Limits.getEmailInvocations();
        
        if (!recordsToArchive.isEmpty()) { 
             Database.delete(recordsToArchive, false);
        }
    }
}