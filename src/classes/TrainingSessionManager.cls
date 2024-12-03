/**
 * Description : To perform Apex Assign 2 on Training Session (CRUD , Enum, Bulk Operation , SOQL Queries, Printing Custom Label ,
 *                Exception Handling , Safe Navigation Operator )
 *
 * Created By : Shubham Raut
 *
 * Created Date : 27/11/24
 *
 * Revision Logs : V1.0 - Created - Shubham Raut
 *
 *
 **/

public with sharing class TrainingSessionManager {
    /**
     *
     * @description : To create Training Sessions
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 27/11/24 - Shubham Raut
     *
     **/
    
    public void createTrainingSession(){
        try {
            List<Training_Session__c> trainingSessionList = new List<Training_Session__c>();
            List<RecordType> recordTypeList = [SELECT Id,Name FROM RecordType WHERE Name = 'Webinar' Or Name = 'Workshop'];
            
            for(Integer i=1; i<6 ; i++){
                Training_Session__c trainingSes = new Training_Session__c();
                trainingSes.Name__c = 'Training '+i;
                trainingSes.Location__c = 'Mumbai';
                
                if(!recordTypeList.isEmpty()){
                    if( Math.mod(i,2) == 0 ){
                        trainingSes.RecordTypeId = recordTypeList.get(0).Id;
                    }else{
                        trainingSes.RecordTypeId = recordTypeList.get(1).Id;
                    }
                }
                
                trainingSessionList.add(trainingSes);
            }
            
            
            if (!trainingSessionList.isEmpty())
                Database.insert(trainingSessionList, false);
        }
        catch (Exception e) {
            System.debug('Error inserting training sessions: ' + e.getMessage());
        }
        
    }
    
    
    /**
     *
     * @description : To Update Training Sessions
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 27/11/24 - Shubham Raut
     *
     **/
    public void updateTrainingSession(){
        try {
            List<Training_Session__c> trainingSessionList = [SELECT Id,Name__c FROM Training_Session__c];
            
            if(!trainingSessionList.isEmpty()){
                
                for(Training_Session__c ts: trainingSessionList){
                    
                    ts.Location__c = 'Jaipur';
                }
                
                Database.update(trainingSessionList,false);
            }
        }
        catch(Exception e){
            System.debug('Error updating records: ' + e.getMessage());
        }
    }
    
    
    /**
     *
     * @description : To create Training Sessions
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 27/11/24 - Shubham Raut
     *
     **/
    public void getTrainingSession(){
        try {
            List<Training_Session__c> trainingSessionList = [SELECT Id,Name__c,Location__c FROM Training_Session__c];
            
            if(!trainingSessionList.isEmpty())
                System.debug('Training Session List : ' + trainingSessionList);
        }
        catch (Exception e) {
            System.debug('Error in getting records: ' + e.getMessage());
        }
        
    }
    
    
    /**
     *
     * @description : To create Training Sessions
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 27/11/24 - Shubham Raut
     *
     **/
    public void deleteTrainingSession(){
        try {
            List<Training_Session__c> trainingSessionList = [SELECT Id FROM Training_Session__c WHERE Name__c = 'Training 1'];
            
            if(!trainingSessionList.isEmpty())
                Database.delete(trainingSessionList,false);
        }
        catch(Exception e){
            System.debug('Error deleting records: ' + e.getMessage());
        }
        
    }
    
    
    /**
     *
     * @description : To Insert Unique Attendee Records to Particular Training Sessions
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 28/11/24 - Shubham Raut
     *
     **/
    
    public void addAttendees(){
        try {
            List<Training_Session__c> trainingSessionList =[SELECT Id FROM Training_Session__c];
            Set<Attendee__c> attSet = new Set<Attendee__c>();
            List<Attendee__c>  attendeeList = new List<Attendee__c>();
            if(!trainingSessionList.isEmpty()){
                for(Training_Session__c ts : trainingSessionList){
                    
                    Attendee__c objAtt = new Attendee__c();
                    objAtt.Name__c = 'Anshul';
                    objAtt.Session__c = ts.Id;
                    attSet.add(objAtt);
                    
                    Attendee__c objAtt2 = new Attendee__c();
                    objAtt2.Name__c = 'Anshul';
                    objAtt2.Session__c = ts.Id;
                    attSet.add(objAtt2);
                    
                }
            }
            attendeeList.addAll(attSet);
            
            if(!attendeeList.isEmpty())
                Database.insert(attendeeList ,false);
        }
        catch(Exception e){
            System.debug('Error inserting records: ' + e.getMessage());
        }
        
        
    }
    
    
    /**
     *
     * @description : To create Training Sessions
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 28/11/24 - Shubham Raut
     *
     **/
    
    public enum  SessionType {
        Webinar, Workshop, Seminar
    }
    
    public void categorizeTrainingSession(){
        try{
            List<Training_Session__c> sessionsList = [SELECT Id,Name__c,Session_Type__c, RecordType.DeveloperName FROM Training_Session__c];
            Map<SessionType, List<Training_Session__c>> categorizeSessionsMap = new Map<SessionType, List<Training_Session__c>>();
            
            
            // Categorizing each training session based on Enum SessionType
            for (Training_Session__c session : sessionsList) {
                SessionType type = SessionType.valueOf(session.RecordType.DeveloperName);
                
                if(!categorizeSessionsMap.containsKey(type)){
                    categorizeSessionsMap.put(type, new List<Training_Session__c>());
                }
                else{
                    categorizeSessionsMap.get(type).add(session);
                }
            }
            
            for (SessionType type : categorizeSessionsMap.keySet()) {
                system.debug('Session Type: ' + type + ', Sessions: ' + categorizeSessionsMap.get(type));
            }
        }
        catch (Exception e) {
            System.debug('Error in categorizing training sessions: ' + e.getMessage());
        }
    }
    
    
    
    /**
     *
     * @description : To safely navigates through Training Session records.
    
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 29/11/24 - Shubham Raut
     *
     **/
    
    public void safeNavigationOp() {
        
        List<Training_Session__c> trainingSessionList = [ SELECT Id, Location__c FROM Training_Session__c];
        
        List<String> listOfString = new List<String>();
        
        if(!trainingSessionList.isEmpty()){
            for(Training_Session__c objTraining : trainingSessionList){
                String locationString = objTraining?.Location__c;
                listOfString.add(locationString);
            }
        }
    }
    
    
    
    /**
     *
     * @description : To Print Messages According to Training Session Type.
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 30/11/24 - Shubham Raut
     *
     **/
    public void getTrainingSessionMessages() {
        List<Training_Session__c> sessionList = [SELECT Id, Name__c, Session_Type__c, RecordType.DeveloperName FROM Training_Session__c];
        
        
        for (Training_Session__c session : sessionList) {
            String sessionMessage;
            
            if (session.RecordType.DeveloperName == 'Webinar') {
                sessionMessage = 'Session: ' + session.Name__c + ' - '+ session.RecordType.DeveloperName + ' - ' + Label.Webinar_Training_Label;
                system.debug(sessionMessage);
            } else if (session.RecordType.DeveloperName == 'Workshop') {
                sessionMessage = 'Session: ' + session.Name__c + ' - '+ session.RecordType.DeveloperName + ' - ' + Label.Workshop_Training_Label;
                system.debug(sessionMessage);
                
            } else if (session.RecordType.DeveloperName == 'Seminar') {
                sessionMessage = 'Session: ' + session.Name__c + ' - '+ session.RecordType.DeveloperName + ' - ' + Label.Seminar_Training_Label;
                system.debug(sessionMessage);
            }
            
        }
        
    }
    
    
    /**
     *
     * @description : To Print Messages According to Training Session Type.
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 30/11/24 - Shubham Raut
     *
     **/
    public void trainingSessionQueries(){
        try {
            List<Training_Session__c> trainingSessionsByDate = [ SELECT Id, Name__c, Session_Date__c FROM Training_Session__c 
                                                    WHERE Session_Date__c >= :Date.newInstance(2024, 11, 1) 
                                                    AND Session_Date__c <= :Date.newInstance(2024, 12, 1) ];
            system.debug('Training Session By Date :' +trainingSessionsByDate);
            
            List<Training_Session__c> trainingSessionsByRecType = [ SELECT Id, Name__c, RecordType.DeveloperName FROM Training_Session__c 
                                                    WHERE RecordType.DeveloperName = 'Webinar'];
            system.debug('Training Session By Webinar :'+trainingSessionsByRecType);
            
            List<Training_Session__c> trainingSessionsByAttendee = [ SELECT Id, Name__c, RecordType.DeveloperName,No_of_Attendees__c FROM Training_Session__c 
                                                    WHERE No_of_Attendees__c > 3];
            system.debug('Training Session By Attendee :'+trainingSessionsByAttendee);
        }
        catch (Exception e) {
            System.debug('Error in getting records: ' + e.getMessage());
        }
    }
    
    
    //==============================================Bulk Operations=================================================================
    
    /**
     *
     * @description : To Log Partial Success Records on Inserting Training Sessions Records.
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 1/11/24 - Shubham Raut
     *
     **/
    public void createTrainingSessionLogging(){
        try {
            List<Training_Session__c> trainingSessionList = new List<Training_Session__c>();
            List<RecordType> recordTypeList = [SELECT Id,Name FROM RecordType WHERE Name = 'Webinar' Or Name = 'Workshop'];
            
            for(Integer i=1; i<6 ; i++){
                Training_Session__c trainingSes = new Training_Session__c();
                trainingSes.Name__c = 'Training Demo '+i;
                
                if(!recordTypeList.isEmpty()){
                    if( Math.mod(i,2) == 0 ){
                        trainingSes.Session_Date__c = Date.today().addDays(30);
                        trainingSes.RecordTypeId = recordTypeList.get(0).Id;
                    }else{
                        trainingSes.RecordTypeId = recordTypeList.get(1).Id;
                    }
                }
                
                trainingSessionList.add(trainingSes);
            }
            
            if (!trainingSessionList.isEmpty()){
                Database.SaveResult[] results = Database.insert(trainingSessionList, false);
                for (Database.SaveResult result : results) {
                    if (result.isSuccess()) {
                        System.debug('Inserted Training Session: ' + result.getId());
                    }
                    else {
                        for (Database.Error error : result.getErrors()) {
                            System.debug('Error inserting Training Session: ' + error.getMessage());
                        }
                    }
                }
            }
        }
        catch (Exception e) {
            System.debug('Error inserting training sessions: ' + e.getMessage());
        }
        
    }
    
    
    /**
     *
     * @description : To Log Partial Success Records on Updating Training Sessions Records.
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 1/12/24 - Shubham Raut
     *
     **/
    public void updateTrainingSessionLogging(){
        try {
            List<Training_Session__c> trainingSessionList = [Select Id,Name__c from Training_Session__c];
            Integer i = 0;
            if(!trainingSessionList.isEmpty()){
                
                for(Training_Session__c trainingSes: trainingSessionList){
                    
                    if( Math.mod(i,2) == 0 ){
                        trainingSes.Session_Date__c = Date.today().addDays(15);
                    }else{
                        trainingSes.Session_Date__c = null;
                    }
                    i++;
                }
                
                Database.SaveResult[] results = Database.update(trainingSessionList, false);
                for (Database.SaveResult result : results) {
                    if (result.isSuccess()) {
                        System.debug('Updated Training Session: ' + result.getId());
                    }
                    else {
                        for (Database.Error error : result.getErrors()) {
                            System.debug('Error updating Training Session: ' + error.getMessage());
                        }
                    }
                }
            }
        }
        catch(Exception e){
            System.debug('Error updating records: ' + e.getMessage());
        }
    }
    
    
    /**
     *
     * @description : To Log Partial Success Records on Deleting Training Sessions Records.
     *
     * @args :
     *
     * @return : void
     *
     * @revision Log : V1.1 - Created - 2/12/24 - Shubham Raut
     *
     **/
    public void deleteTrainingSessionLogging(){
        try {
            List<Training_Session__c> trainingSessionList = [Select Id from Training_Session__c ];
            
            if(!trainingSessionList.isEmpty()){
                Database.DeleteResult[] results = Database.delete(trainingSessionList, false);
                for (Database.DeleteResult result : results) {
                    if (result.isSuccess()) {
                        System.debug('Deleted Training Session: ' + result.getId());
                    }
                    else {
                        for (Database.Error error : result.getErrors()) {
                            System.debug('Error deleting Training Session: ' + error.getMessage());
                        }
                    }
                }
            }
        }
        catch(Exception e){
            System.debug('Error deleting records: ' + e.getMessage());
        }
        
    }
    
}