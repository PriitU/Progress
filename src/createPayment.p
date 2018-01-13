 				  				 
 				 
/*------------------------------------------------------------------------
    File        : createPayment.p
    Project     : Progress-master
    Author(s)   : IEUser
    Created     : Wed Jan 10 12:20:55 PST 2018
    Notes       :
    Description :
  ----------------------------------------------------------------------*/ 				 

	
	TRIGGER PROCEDURE FOR CREATE OF PaymentHistory.	 
	
	ASSIGN PaymentHistory.PaymentHistoryId = NEXT-VALUE(PAYMENTHISTORYID). 