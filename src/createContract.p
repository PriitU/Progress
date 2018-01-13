 				  				 
 				 
/*------------------------------------------------------------------------
    File        : createContract.p
    Project     : ProjectServer
    Author(s)   : ulmas
    Created     : Sun Dec 31 10:02:08 EET 2017
    Notes       :
    Description :
  ----------------------------------------------------------------------*/ 				 
 
	TRIGGER PROCEDURE FOR CREATE OF Contract.
    
    ASSIGN Contract.ContractId = NEXT-VALUE(CONTRACTID).
    
 
   