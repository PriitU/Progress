
 /*------------------------------------------------------------------------
    File        : beContractHistory
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : IEUser
    Created     : Tue Jan 02 11:15:52 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="ContractHistoryId").
@openapi.openedge.entity.required (fields="ContractHistoryId,ContractId").
	
DEFINE TEMP-TABLE ttContractHistory BEFORE-TABLE bttContractHistory
FIELD ContractHistoryId AS INTEGER
FIELD CustomerId AS INTEGER
FIELD ContractNr AS CHARACTER
FIELD Amount AS INTEGER
FIELD AmountLeft AS INTEGER
FIELD ContractStatus AS INTEGER
FIELD ContractId AS INTEGER
FIELD TimeIn AS DATETIME
FIELD TimeEnded AS DATETIME
FIELD PaymentDate AS DECIMAL
FIELD Edit AS CHARACTER
INDEX ContractHistoryId IS  PRIMARY  UNIQUE  ContractHistoryId  ASCENDING . 


DEFINE DATASET dsContractHistory FOR ttContractHistory.