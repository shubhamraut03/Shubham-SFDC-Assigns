/**
* Description :  It Contains Lead Processor Batch Class Test Methods.             
*
* Created By : Shubham Raut
*
* Created Date : 18/12/24
*
* Revision Logs : V1.0 - Created - Shubham Raut
*
**/
@isTest
private class LeadProcessorBatchTest {

    @testSetup
    private static void createLead(){
        
        List<Lead> listOfLead = TestDataFactory.createLeadRec('Test Lead', 200, false);
        
        for(Lead objLead : listOfLead){
            
            objLead.Company = 'GS Dynamics';
            objLead.Status = 'Open - Not Contacted';
            objLead.LeadSource = 'Web';
        }
        
        insert listOfLead;
    }
    
    @isTest
    private static void updateLeadBatch(){

        Test.startTest();
        LeadProcessorBatch leadBatch = new LeadProcessorBatch();
        Database.executeBatch(leadBatch);
        Test.stopTest();
        
        List<Lead> listOfUpdatedLead = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        Assert.areEqual(200, listOfUpdatedLead.size(), 'Batch did not processed successfully!');
    }
}