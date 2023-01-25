public with sharing class product {
    public static void make() {
        
        list<string> Pname = new list<string>{'Product 1','I7 processer','I5 processer','I3 processer','CORE TWO processer','DOUBLE CORE processer','Samsung Moniter','Acer Moniter','Vivo Moniter','Mouse'};
            list<product2> ProductDetail = new list<product2>();
        for(integer i=0;i<Pname.size();i++)
        {
            
            product2 obj = new product2();
            obj.name = Pname[i];
            obj.isActive = true;
            obj.Family='Hardware';
            ProductDetail.add(obj);
        }
        
        try{
            insert ProductDetail;
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
        id standredPricebook  = [SELECT id ,isStandard from Pricebook2 where isStandard=true].id;
        
        list<pricebookentry> pricesEntryStandred = new list<pricebookentry>();
        
        for(integer i=0;i<Pname.size();i++)
        {
            pricebookentry obj = new pricebookentry();
            //obj.name =  'Laptop PriceBook Enrty '+i;
            obj.pricebook2id = standredPricebook;
            obj.product2id =ProductDetail[i].id; 
            obj.unitprice = i*10+1;
            obj.isActive= true;
            pricesEntryStandred.add(obj);
        }
        try{
            insert pricesEntryStandred;    
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
        list<product2> ids = new list<product2>([SELECT id,name from product2 where name in: Pname]);
        
        
        pricebook2 CustomPricebook = new pricebook2();
        CustomPricebook.name = 'Laptop PriceBook';
        CustomPricebook.isActive = true;
        try{
            insert CustomPricebook;    
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
        list<pricebookentry> pricesEntry = new list<pricebookentry>();
        for(integer i=0;i<Pname.size();i++)
        {
            pricebookentry obj = new pricebookentry();
            //obj.name =  'Laptop PriceBook Enrty '+i;
            obj.pricebook2id = CustomPricebook.id;
            obj.product2id =ProductDetail[i].id; 
            obj.unitprice = i*10+1;
            obj.isActive = true;
            pricesEntry.add(obj);
        }
        
        try{
            insert pricesEntry;    
        }
        catch(DmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        system.debug('Hello ===>'+ids);
        
    }
}