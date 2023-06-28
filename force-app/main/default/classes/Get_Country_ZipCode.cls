/**********************************************************************
Setup Configurations
1. Add "https://api.zippopotam.us" to Remote Sites

Version Author Details
1.0 - Christian Perez 28/06/2023 Initial Development
***********************************************************************/
Public with sharing class Get_Country_ZipCode{
    //Method enabled to use in LWC
    @AuraEnabled
    Public static object getCountryZipCode(String zipCode){
        try{
            Get_Country_ZipCode callM = new Get_Country_ZipCode();
            Map<String, Object> resT = callM.makeCallOut(zipCode);
            if(!String.isEmpty((String) resT.get('country abbreviation')) && (String) resT.get('country abbreviation') != 'US'){
                system.debug('Saving record...');
                Zip_Code__c resp = new Zip_Code__c();
                resp.Requested_Zip_Code__c = zipCode;
                resp.Country_Code__c = (String) resT.get('Country');
                resp.Api_Response__c = (String) resT.get('Result');
                insert resp;
            }
            return resT;
        } catch(Exception e){
            system.debug(e.getMessage() + ' Line: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    //Method to make callout
    Public Map<String, Object> makeCallOut(String zipCode){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.zippopotam.us/us/' + zipCode);//Dinamic endpoint, dependes of Zipcode provided by user
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            //Deserializes the JSON string into collections of primitive data types
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug(results.get('country abbreviation'));
            Map<String, Object> mapRes = new Map<String, Object>();
            mapRes.put('Country', (String) results.get('country abbreviation'));
            mapRes.put('Result', response.getBody());
            return mapRes;
        }
        return null;
    }   
    
    //Method enabled to use in flows
    @InvocableMethod(label='Make callout' description='Method to create callaout from flow' callout=true)
    Public static List<FlowOutput> getCountryZipCodeFlow(List<String> zipCode){
        List<FlowOutput> idsOrCn= new List<FlowOutput>();
        try{
            Get_Country_ZipCode callM = new Get_Country_ZipCode();
            Map<String, Object> res = (Map<String, Object>) callM.makeCallOut(zipCode[0]);
            FlowOutput nO = new FlowOutput();
            nO.country = (String) res.get('Country');
            nO.result = (String) res.get('Result');
            idsOrCn.add(nO);
            return idsOrCn;//Return values to use in Flow
        } catch(Exception e){
            system.debug(e.getMessage() + ' Line: ' + e.getLineNumber());
            throw new AuraHandledException(e.getMessage());
        }
    }
    
    Public class FlowOutput{
        @InvocableVariable() Public String country;
        @InvocableVariable() Public String result;
    }
}