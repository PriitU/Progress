 
 /*------------------------------------------------------------------------
    File        : beCustomerContracts
    Syntax      : 
    Author(s)   : IEUser
    Created     : Sun Jan 07 02:54:42 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="beCustomerContracts.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="beCustomerContracts", URI="/beCustomerContracts", schemaName="dsCustomerContracts", schemaFile="Progress-master/src/AppServer/becustomercontracts.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS beCustomerContracts INHERITS BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"AppServer\becustomercontracts.i"}
    
    
    /* TODO Fill in appropriate datasource tables */ 
    DEFINE DATA-SOURCE srcttCustomer FOR Customer. 
    DEFINE DATA-SOURCE srcttContract FOR Contract.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC beCustomerContracts():
        
        DEFINE VARIABLE hDataSourceArray AS HANDLE NO-UNDO EXTENT 2.
        DEFINE VARIABLE cSkipListArray AS CHARACTER NO-UNDO EXTENT 2.
        
        SUPER (DATASET dsCustomerContracts:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */ 
         hDataSourceArray[1] = DATA-SOURCE srcttCustomer:HANDLE.
         hDataSourceArray[2] = DATA-SOURCE srcttContract:HANDLE.
                  
         /* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
            ignored in create stmt */
         
         /* TODO Update cSkipListArray if required by your BusinessEntity */
         cSkipListArray[1] = ?.
         cSkipListArray[2] = ?.
         
         THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
                 
    END CONSTRUCTOR.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadbeCustomerContracts(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsCustomerContracts):
        
        SUPER:ReadData(filter).
              
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreatebeCustomerContracts(INPUT-OUTPUT DATASET dsCustomerContracts):            
               
        SUPER:CreateData(DATASET dsCustomerContracts BY-REFERENCE).        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdatebeCustomerContracts(INPUT-OUTPUT DATASET dsCustomerContracts):            
    
        SUPER:UpdateData(DATASET dsCustomerContracts BY-REFERENCE).          
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeletebeCustomerContracts(INPUT-OUTPUT DATASET dsCustomerContracts):                    
    
        SUPER:DeleteData(DATASET dsCustomerContracts BY-REFERENCE).
    END METHOD.
    
     
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records from the ttCustomer table, 
                      based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="invoke", URI="/GetttCustomer", alias="", mediaType="application/json").
    METHOD PUBLIC VOID GetttCustomer( 
            INPUT filter AS CHARACTER, 
            OUTPUT TABLE ttCustomer ):
             
        /* TODO: Add code to get records from a specific table and return 
           the resulting records to the client. */  
    END METHOD.
     
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records from the ttContract table, 
                      based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="invoke", URI="/GetttContract", alias="", mediaType="application/json").
    METHOD PUBLIC VOID GetttContract( 
            INPUT filter AS CHARACTER, 
            OUTPUT TABLE ttContract ):
             
        /* TODO: Add code to get records from a specific table and return 
           the resulting records to the client. */  
    END METHOD. 
    
END CLASS.
