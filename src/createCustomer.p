 				  				 
 				 
/*------------------------------------------------------------------------
    File        : createCust.p
    Project     : ProjectServer
    Author(s)   : ulmas
    Created     : Fri Dec 29 18:05:26 EET 2017
    Notes       :
    Description :
  ----------------------------------------------------------------------*/ 				 

	
	TRIGGER PROCEDURE FOR CREATE OF Customer.	 

    ASSIGN Customer.CustomerId = NEXT-VALUE(CUSTOMERID).
