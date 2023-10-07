public class SpringSOARollUpConApex {
    
    
    public static void rollUpSummeryOnContact(List<contact> conList , map<id,contact> oldMap , triggerOperation operation){
        
        Set<id> accIds = new Set<id>();
        Map<id,Decimal> totalConMap = new Map<id,Decimal>();
        List<Account> accToUpdate = new List<Account>();
        
        if(operation == TriggerOperation.AFTER_INSERT || operation == triggerOperation.AFTER_UPDATE){
            if(!conList.isEmpty()){
                for(contact c : conList){
                    if(c.AccountId != null){
                        accIds.add(c.AccountId);
                    }
                }
            }
        }
        else if(operation == triggerOperation.AFTER_DELETE){
            for(contact c : oldMap.values()){
                if(c.AccountId != null){
                    accIds.add(c.AccountId);
                }
            }
            
            if(!accIds.isEmpty()){
                List<AggregateResult> results = [SELECT count(id)total , AccountId from Contact WHERE AccountId IN: accIds GROUP BY AccountId ];
                if(!results.isEmpty()){
                    for(AggregateResult res : results){
                        decimal count = (decimal)res.get('total');
                        // system.debug('count is :::' + count);
                        id accountId = (Id)res.get('AccountId');
                        //system.debug('Id is :::' + accountId);
                        if(count != null && accountId != null){
                            totalConMap.put(accountId , count);
                        }
                    }
                }
            }
            if(!totalConMap.isEmpty()){
                List<Account> accList = [SELECT id ,Number_of_Contacts__c from Account WHERE Id IN : totalConMap.keySet()];
                if(!accList.isEmpty()){
                    for(Account a : accList){
                        a.Number_of_Contacts__c = totalConMap.get(a.Id);
                        accToUpdate.add(a);
                    }
                }
            }
            if(!accToUpdate.isEmpty()){
                Update accToUpdate;
            }
        }
    }
}