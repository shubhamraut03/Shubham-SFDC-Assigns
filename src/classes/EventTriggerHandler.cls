public class EventTriggerHandler {

     public static void rollupEventOnAccount(List<Event> listOfEvent, Map<Id, Event> oldMapOfEvent){
        Set<Id> setOfIds = new Set<Id>();
        
        for(Event objEvent : listOfEvent){
            
            if(objEvent.WhatId != null){
                
                setOfIds.add(objEvent.WhatId);
            }
            
            
        }
        
        
        Map<Id, Integer> mapOfActivitiesCountOnAccount = new Map<Id, Integer>();
        Map<Id, Integer> mapOfOpenActivitiesCountOnAccount = new Map<Id, Integer>();
        Map<Id, Integer> mapOfClosedActivitiesCountOnAccount = new Map<Id, Integer>();
        
        
        AggregateResult[] resultCountAggregate = [Select COUNT_DISTINCT(Id) activitiesCount, WhatId from Event 
                                                  where WhatId IN : setOfIds GROUP BY WhatId];
        
        for(AggregateResult objAggregate : resultCountAggregate){
            
            mapOfActivitiesCountOnAccount.put((Id) objAggregate.get('WhatId'), 
                                              (Integer) objAggregate.get('activitiesCount'));
        }
        
        AggregateResult[] resultCountOpenActivitiesAggregate = [Select COUNT_DISTINCT(Id) activitiesCount, WhatId from Event 
                                                                where WhatId IN : setOfIds AND Status__c ='Open' GROUP BY WhatId];
        
        for(AggregateResult objAggregate : resultCountOpenActivitiesAggregate){
            
            mapOfOpenActivitiesCountOnAccount.put((Id) objAggregate.get('WhatId'), 
                                                  (Integer) objAggregate.get('activitiesCount'));
        }
        
        AggregateResult[] resultClosedActivitiesAggregate = [Select COUNT_DISTINCT(Id) activitiesCount, WhatId from Event 
                                                             where WhatId IN : setOfIds AND Status__c ='Closed' GROUP BY WhatId];
        
        for(AggregateResult objAggregate : resultClosedActivitiesAggregate){
            
            mapOfClosedActivitiesCountOnAccount.put((Id) objAggregate.get('WhatId'), 
                                                    (Integer) objAggregate.get('activitiesCount'));
        }
        
        List<Account> listOfAccount = new List<Account>();
        
        for(Id accId : setOfIds){
            
            Account objAcc = new Account();
            objAcc.Id = accId;
           
            if(mapOfActivitiesCountOnAccount.containsKey(accId) && mapOfActivitiesCountOnAccount.get(accId) != null){
                            objAcc.Total_Activities__c = objAcc.Total_Activities__c + mapOfActivitiesCountOnAccount.get(accId);

            }
             if(mapOfOpenActivitiesCountOnAccount.containsKey(accId) && mapOfActivitiesCountOnAccount.get(accId) != null){
            objAcc.Total_Open_Activities__c = objAcc.Total_Closed_Activities__c + objAcc.Total_Open_Activities__c + mapOfActivitiesCountOnAccount.get(accId) ;

            }
            
             if(mapOfClosedActivitiesCountOnAccount.containsKey(accId) && mapOfActivitiesCountOnAccount.get(accId) != null){
            objAcc.Total_Closed_Activities__c =  objAcc.Total_Closed_Activities__c + mapOfActivitiesCountOnAccount.get(accId);

            }
            listOfAccount.add(objAcc);
        }
        
        
        if(!listOfAccount.isEmpty())
            update listOfAccount;
        
    }
    }