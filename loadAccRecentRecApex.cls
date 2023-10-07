public with sharing class loadAccRecentRecApex {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccData(){
        try {
            return [SELECT id , Name , website,rating,industry from account  Order by CreatedDate  DESC LIMIT 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}