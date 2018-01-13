 				  				 
 				 
/*------------------------------------------------------------------------
    File        : writeCust.p
    Project     : ProjectServer
    Author(s)   : ulmas
    Created     : Fri Dec 29 19:58:32 EET 2017
    Notes       :
    Description :
  ----------------------------------------------------------------------*/ 				 

	
	TRIGGER PROCEDURE FOR WRITE OF Customer OLD BUFFER oldCustomer.
    DEFINE VARIABLE update_text AS CHARACTER. 
    update_text = 'Update: '.
    IF oldCustomer.FirstName <> Customer.FirstName THEN DO:
        update_text = update_text + "FirstName ".
     END.     
    IF oldCustomer.LastName <> Customer.LastName THEN DO:
        update_text = update_text + "LastName ".
     END. 
     IF oldCustomer.IdCode <> Customer.IdCode THEN DO:
        update_text = update_text + "IdCode ".
     END. 

    CREATE CustomerHistory.
    ASSIGN
        CustomerHistory.CustomerHistoryId = NEXT-VALUE(CUSTOMERHISTORYID)
        CustomerHistory.CustomerId = Customer.CustomerId
        CustomerHistory.FirstName = Customer.FirstName
        CustomerHistory.LastName = Customer.LastName
        CustomerHistory.IdCode = Customer.IdCode
        CustomerHistory.Edit = update_text.
