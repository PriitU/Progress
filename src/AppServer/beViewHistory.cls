 
 /*------------------------------------------------------------------------
    File        : beViewHistory
    Syntax      : 
    Author(s)   : IEUser
    Created     : Sun Jan 07 10:44:08 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="beViewHistory.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="beViewHistory", URI="/beViewHistory", schemaName="dsViewHistory", schemaFile="Progress-master/src/AppServer/beviewhistory.i").

USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS beViewHistory INHERITS BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"AppServer\beviewhistory.i"}
    
    /* TODO Fill in appropriate datasource tables */ 
    DEFINE DATA-SOURCE srcttContract FOR Contract. 
    DEFINE DATA-SOURCE srcttContractHistory FOR ContractHistory.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC beViewHistory():
        
        DEFINE VARIABLE hDataSourceArray AS HANDLE NO-UNDO EXTENT 2.
        DEFINE VARIABLE cSkipListArray AS CHARACTER NO-UNDO EXTENT 2.
        
        SUPER (DATASET dsViewHistory:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */ 
         hDataSourceArray[1] = DATA-SOURCE srcttContract:HANDLE.
         hDataSourceArray[2] = DATA-SOURCE srcttContractHistory:HANDLE.
                  
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
    METHOD PUBLIC VOID ReadbeViewHistory(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsViewHistory):
        
        SUPER:ReadData(filter).
              
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreatebeViewHistory(INPUT-OUTPUT DATASET dsViewHistory):            
               
        SUPER:CreateData(DATASET dsViewHistory BY-REFERENCE).        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdatebeViewHistory(INPUT-OUTPUT DATASET dsViewHistory):            
    
        SUPER:UpdateData(DATASET dsViewHistory BY-REFERENCE).          
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeletebeViewHistory(INPUT-OUTPUT DATASET dsViewHistory):                    
    
        SUPER:DeleteData(DATASET dsViewHistory BY-REFERENCE).
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
     
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records from the ttContractHistory table, 
                      based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="invoke", URI="/GetttContractHistory", alias="", mediaType="application/json").
    METHOD PUBLIC VOID GetttContractHistory( 
            INPUT filter AS CHARACTER, 
            OUTPUT TABLE ttContractHistory ):
             
        /* TODO: Add code to get records from a specific table and return 
           the resulting records to the client. */  
    END METHOD. 
    
END CLASS.
