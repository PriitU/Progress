
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
//@openapi.openedge.entity.field.property (field="Amount", name="semanticType", type="object", value='~{"type": "Currency","min":0,"max":9999999~}').
@openapi.openedge.entity.primarykey (fields="ContractId").
@openapi.openedge.entity.required (fields="ContractId,ContractNr,CustomerId").
@openapi.openedge.entity.foreignkey (  name="ttCustomerFK1", fields="CustomerId", parent="beCustomer.ttCustomer", parentFields="CustomerId" ).
@openapi.openedge.entity.field.property (field="Amount", name="semanticType", type="object", value='~{"type": "Integer","min":0,"max":999~}').
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
    INDEX ContractId IS  PRIMARY  ContractId
    INDEX ContractNr IS  UNIQUE  ContractNr. 


DEFINE DATASET dsContract FOR ttContract.