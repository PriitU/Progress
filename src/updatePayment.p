 				  				 
 				 
/*------------------------------------------------------------------------
    File        : updatePayment.p
    Project     : Progress-master
    Author(s)   : IEUser
    Created     : Sun Jan 07 04:45:31 PST 2018
    Notes       :
    Description :
  ----------------------------------------------------------------------*/ 				 

	
	TRIGGER PROCEDURE FOR WRITE OF PaymentHistory.	 
	
    IF PaymentHistory.PaymentAmount <= 0 THEN
        RETURN ERROR "Payment must be larger than zero".
    
    IF CAN-FIND(FIRST Contract NO-LOCK
        WHERE Contract.ContractNr = PaymentHistory.ContractNr)=FALSE THEN
            RETURN ERROR "Cannot find chosen contract.".
    
    DEFINE VARIABLE amount_left AS INT.
    DEFINE VARIABLE contract_status AS INT.
    FIND FIRST Contract WHERE Contract.ContractNr = PaymentHistory.ContractNr NO-ERROR.
        DISABLE TRIGGERS FOR LOAD OF Contract.  
        contract_status = Contract.ContractStatus.
        amount_left = Contract.Amount - (Contract.Amount - Contract.AmountLeft) - PaymentHistory.PaymentAmount.         
        ASSIGN
            Contract.AmountLeft = amount_left
            Contract.PaymentDate = PaymentHistory.PaymentTime.
        IF amount_left <= 0 THEN DO:
            contract_status = 2.
            ASSIGN 
                Contract.ContractStatus =  2
                Contract.TimeEnded = Contract.PaymentDate.
        END.
        //record change to log file
        MESSAGE "Order amount reduced by" PaymentHistory.PaymentAmount.
     
    CREATE ContractHistory.
    ASSIGN
        ContractHistory.ContractHistoryId = NEXT-VALUE(CONTRACTHISTORYID)
        ContractHistory.ContractId = Contract.ContractId
        ContractHistory.CustomerId = Contract.CustomerId
        ContractHistory.ContractNr = Contract.ContractNr
        ContractHistory.ContractStatus = contract_status
        ContractHistory.TimeIn = Contract.TimeIn
        ContractHistory.TimeEnded = Contract.TimeEnded
        ContractHistory.Amount = Contract.Amount
        ContractHistory.AmountLeft = amount_left
        ContractHistory.PaymentDate = Contract.PaymentDate
        ContractHistory.Edit = "Payment recieved".