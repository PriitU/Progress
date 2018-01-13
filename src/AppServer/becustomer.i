
 /*------------------------------------------------------------------------
    File        : beCustomer
    Purpose		:
    Syntax      : 
    Description :
    Author(s)   : IEUser
    Created     : Tue Jan 02 11:18:36 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
  /* ***************************  Definitions  ************************** */
  
  /* ********************  Preprocessor Definitions  ******************** */
  
  /* ***************************  Main Block  *************************** */
  
  /** Dynamically generated schema file **/
   
@openapi.openedge.entity.primarykey (fields="IdCode").
@openapi.openedge.entity.required (fields="CustomerId,IdCode,FirstName,LastName").
    
DEFINE TEMP-TABLE ttCustomer BEFORE-TABLE bttCustomer
FIELD CustomerId AS INTEGER
FIELD IdCode AS CHARACTER
FIELD FirstName AS CHARACTER
FIELD LastName AS CHARACTER
INDEX CustomerId IS UNIQUE  CustomerId  ASCENDING 
INDEX IdCode IS  PRIMARY  UNIQUE  IdCode  ASCENDING . 


DEFINE DATASET dsCustomer FOR ttCustomer.