
/*------------------------------------------------------------------------
    File        : custom.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Wed Jan 10 12:01:15 PST 2018
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
/*    
       FOR EACH ContractHistory WHERE ContractHistory.ContractStatus = 0:
           DELETE ContractHistory.
       END.
   
       FOR EACH CustomerHistory WHERE CustomerHistory.CustomerId >= 0:
           DELETE CustomerHistory.
       END.
       
       FOR EACH PaymentHistory WHERE PaymentHistory.PaymentAmount >= 0:
           DELETE PaymentHistory.
       END.
       */