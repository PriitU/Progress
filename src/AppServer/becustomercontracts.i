
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
   /*   
@openapi.openedge.entity.foreignkey (  name="ttCustomerFK1", fields="CustomerId", parent="beCustomers.ttCustomer", parentFields="CustomerId" ).
*/

@openapi.openedge.entity.primarykey ( fields="ContractId").
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
INDEX ContractId IS  PRIMARY  UNIQUE  ContractId  ASCENDING 
INDEX CustomerId CustomerId
INDEX ContractNr IS  UNIQUE  ContractNr  ASCENDING . 


@openapi.openedge.entity.primarykey (fields="CustomerId").
DEFINE TEMP-TABLE ttCustomer BEFORE-TABLE bttCustomer
    FIELD CustomerId AS INTEGER
    FIELD FirstName AS CHARACTER
    FIELD LastName AS CHARACTER
    FIELD IdCode AS CHARACTER
    INDEX CustomerId IS  PRIMARY  UNIQUE  CustomerId  ASCENDING.


DEFINE DATASET dsCustomerContracts 
    FOR ttCustomer, ttContract
    DATA-RELATION drCustomerContracts FOR ttCustomer, ttContract
    REPOSITION RELATION-FIELDS (CustomerId, CustomerId).