
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

@openapi.openedge.entity.primarykey (fields="IdCode").
@openapi.openedge.entity.required (fields="CustomerId").
DEFINE TEMP-TABLE ttCustomer BEFORE-TABLE bttCustomer
    FIELD CustomerId AS INTEGER
    FIELD IdCode AS CHARACTER
    FIELD FirstName AS CHARACTER
    FIELD LastName AS CHARACTER
    INDEX CustomerId IS UNIQUE  CustomerId  ASCENDING 
    INDEX IdCode IS  PRIMARY  UNIQUE  IdCode  ASCENDING .  

DEFINE TEMP-TABLE ttCustomerHistory BEFORE-TABLE bttCustomerHistory
    FIELD CustomerHistoryId AS INTEGER
    FIELD CustomerId AS INTEGER
    FIELD FirstName AS CHARACTER
    FIELD LastName AS CHARACTER
    FIELD IdCode AS CHARACTER
    FIELD Edit AS CHARACTER
    FIELD HistoryTime AS DATETIME
    INDEX CustomerHistoryId IS  PRIMARY   CustomerHistoryId  ASCENDING . 

DEFINE DATASET dsViewCustomerHistory
    FOR ttCustomer, ttCustomerHistory
    DATA-RELATION drViewCustomerHistory FOR ttCustomer, ttCustomerHistory
    REPOSITION RELATION-FIELDS (CustomerId, CustomerId).