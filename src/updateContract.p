 				  				 
 				 
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

    IF Contract.ContractNr="" THEN
        RETURN ERROR "Contract number cannot be empty".
        
    IF Contract.Amount <= 0 THEN
        RETURN ERROR "Amount must be larger than 0".
        
    IF CAN-FIND(FIRST Customer NO-LOCK
        WHERE Customer.CustomerId = Contract.CustomerId)=FALSE THEN
            RETURN ERROR "Cannot find chosen customer.".
        
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
            ContractHistory.HistoryTime = NOW
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
    	
    	
	
    