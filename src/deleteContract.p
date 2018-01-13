 				  				 
 				 
/*------------------------------------------------------------------------
    File        : deleteContract.p
    Project     : ProjectServer
    Author(s)   : ulmas
    Created     : Sun Dec 31 17:08:22 EET 2017
    Notes       :
    Description :
  ----------------------------------------------------------------------*/ 				 

	
	TRIGGER PROCEDURE FOR DELETE OF Contract.	
	
	IF Contract.ContractStatus = 2 THEN DO:
	   FOR EACH ContractHistory WHERE ContractHistory.ContractId = Contract.ContractId:
	       DELETE ContractHistory.
	   END.
	   MESSAGE "Contract history deleted.".
	END.
	ELSE DO:
        RETURN ERROR "Cannot delete active contract.". 
	END.