
 /*------------------------------------------------------------------------
    File        : beContract
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : IEUser
    Created     : Tue Jan 02 10:50:10 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/

@openapi.openedge.entity.primarykey (fields="ContractId").
DEFINE TEMP-TABLE ttContract BEFORE-TABLE bttContract
    FIELD ContractId AS INTEGER
    FIELD ContractNr AS CHARACTER
    FIELD CustomerId AS INTEGER
    FIELD Amount AS INTEGER
    FIELD AmountLeft AS INTEGER
    FIELD ContractStatus AS INTEGER
    FIELD TimeIn AS DATETIME
    FIELD TimeEnded AS DATETIME
    FIELD PaymentDate AS DATETIME
    INDEX ContractId IS  PRIMARY UNIQUE ContractId. 

@openapi.openedge.entity.primarykey (fields="ContractHistoryId").
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
    FIELD ContractHistoryTime AS DATETIME
    FIELD Edit AS CHARACTER
    INDEX ContractHistoryId IS  PRIMARY  UNIQUE  ContractHistoryId  ASCENDING. 

DEFINE DATASET dsViewHistory
    FOR ttContract, ttContractHistory
    DATA-RELATION drViewHistory FOR ttContract, ttContractHistory
    REPOSITION RELATION-FIELDS (ContractId, ContractId).