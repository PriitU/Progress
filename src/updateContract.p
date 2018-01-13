 				  				 
 				 
/*------------------------------------------------------------------------
    File        : updateContract.p
    Project     : ProjectServer
    Author(s)   : ulmas
    Created     : Sun Dec 31 14:25:24 EET 2017
    Notes       :
    Description :
  ----------------------------------------------------------------------*/ 				 

	
TRIGGER PROCEDURE FOR WRITE OF Contract OLD BUFFER oldContract.	 
    MESSAGE Contract.ContractNr.
    MESSAGE oldContract.ContractNr.

    CREATE ContractHistory.
        ASSIGN 
            ContractHistory.ContractHistoryId = NEXT-VALUE(CONTRACTHISTORYID)
            ContractHistory.ContractId = Contract.ContractId
            ContractHistory.CustomerId = Contract.CustomerId
            ContractHistory.ContractNr = Contract.ContractNr
            ContractHistory.ContractStatus = Contract.ContractStatus
            ContractHistory.TimeIn = Contract.TimeIn
            ContractHistory.TimeEnded = Contract.TimeEnded
            ContractHistory.Amount = Contract.Amount
            ContractHistory.AmountLeft = Contract.AmountLeft
            ContractHistory.PaymentDate = Contract.PaymentDate.
                 
    IF Contract.ContractNr <> oldContract.ContractNr THEN DO:     
        ASSIGN 
            Contract.AmountLeft = Contract.Amount   
            ContractHistory.Edit = "Create"
            ContractHistory.AmountLeft = Contract.AmountLeft.  
    END.
    ELSE DO:
        ASSIGN ContractHistory.Edit = "Update".
    END.	
    	
    	
	
    