 				  				 
 				 
/*------------------------------------------------------------------------
    File        : deleteCustomer.p
    Project     : Progress-master
    Author(s)   : IEUser
    Created     : Sun Jan 07 03:25:42 PST 2018
    Notes       :
    Description :
  ----------------------------------------------------------------------*/ 				 

	
	TRIGGER PROCEDURE FOR DELETE OF Customer.	 
        IF CAN-FIND (FIRST Contract NO-LOCK OF Customer) THEN DO:
            RETURN ERROR "Ongoing contracts exist for this cutomer, cannot delete the customer.".   
        END.   
        ELSE DO:
            FOR EACH CustomerHistory WHERE CustomerHistory.CustomerId = Customer.CustomerId:
                DELETE CustomerHistory.
            END.
            //record deletion to log file
            MESSAGE Customer.CustomerId " history deleted.".
            MESSAGE "Customer deleted.".
            RETURN.
        END. 