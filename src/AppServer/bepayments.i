
 /*------------------------------------------------------------------------
    File        : bePayments
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : IEUser
    Created     : Tue Jan 02 11:19:10 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.required (fields="PaymentAmount,PaymentHistoryId").
@openapi.openedge.entity.foreignkey (  name="ttContractFK2", fields="ContractNr", parent="beContract.ttContract", parentFields="ContractNr" ).
DEFINE TEMP-TABLE ttPaymentHistory BEFORE-TABLE bttPaymentHistory
FIELD PaymentHistoryId AS INTEGER INITIAL "0"
FIELD PaymentAmount AS INTEGER INITIAL "0"
FIELD PaymentTime AS DATETIME
FIELD ContractNr AS CHARACTER
INDEX PaymentHistoryId IS  PRIMARY   PaymentHistoryId  ASCENDING . 


DEFINE DATASET dsPaymentHistory FOR ttPaymentHistory.