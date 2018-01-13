 
 /*------------------------------------------------------------------------
    File        : beContractHistory
    Syntax      : 
    Author(s)   : IEUser
    Created     : Tue Jan 02 11:15:52 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="beContractHistory.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="beContractHistory", URI="/beContractHistory", schemaName="dsContractHistory", schemaFile="Progress-master/src/AppServer/becontracthistory.i").

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS beContractHistory:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"src\AppServer\becontracthistory.i"}
    
    DEFINE DATA-SOURCE srcContractHistory FOR data2.ContractHistory.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadbeContractHistory(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsContractHistory):
        
        DEFINE VARIABLE pcWhere AS CHARACTER.
        IF filter BEGINS "WHERE " THEN
            pcWhere = filter.
        ELSE IF filter NE "" THEN
            pcWhere = "WHERE " + filter.              
    
        THIS-OBJECT:applyFillMethod (INPUT pcWhere).       
        RETURN.          
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreatebeContractHistory(INPUT-OUTPUT DATASET dsContractHistory):                                  
    
        THIS-OBJECT:CommitbeContractHistory(INPUT "", INPUT ROW-CREATED).        
        RETURN.        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdatebeContractHistory(INPUT-OUTPUT DATASET dsContractHistory):            
    
    
        THIS-OBJECT:CommitbeContractHistory(INPUT "", INPUT ROW-MODIFIED).
                      
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeletebeContractHistory(INPUT-OUTPUT DATASET dsContractHistory):                    
    
    
        THIS-OBJECT:CommitbeContractHistory(INPUT "", INPUT ROW-DELETED).
        
    END METHOD.
     
    
    /*------------------------------------------------------------------------------
            Purpose:  generic routine for creating/updating/deleting customers                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID commitbeContractHistory(
                    INPUT pcFieldMapping AS CHARACTER,
                    INPUT piRowState AS INTEGER ):
        DEFINE VARIABLE Skip-list AS CHARACTER NO-UNDO.
        BUFFER ttContractHistory:ATTACH-DATA-SOURCE (DATA-SOURCE srcContractHistory:HANDLE,
                                             pcFieldMapping).
        FOR EACH ttContractHistory.
            BUFFER ttContractHistory:MARK-ROW-STATE (piRowState). 
        END.
        IF piRowState = ROW-CREATED THEN
            Skip-list  = "ContractHistoryId".
        FOR EACH bttContractHistory:
            BUFFER bttContractHistory:SAVE-ROW-CHANGES(1, Skip-list).
        END.
        FINALLY:
            BUFFER ttContractHistory:DETACH-DATA-SOURCE().
        END FINALLY.
    END METHOD.
    /*------------------------------------------------------------------------------
            Purpose:  Generic routine for FILL method on gets/load                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID applyFillMethod(INPUT pcWhere AS CHARACTER):
        
        /* get rid of any existing data */
        EMPTY TEMP-TABLE ttContractHistory.
        BUFFER ttContractHistory:ATTACH-DATA-SOURCE(DATA-SOURCE srcContractHistory:HANDLE).
        //IF pcWhere NE "" THEN 
        //    DATA-SOURCE srcContractHistory:FILL-WHERE-STRING = pcWhere.
        DATASET dsContractHistory:FILL().
        BUFFER ttContractHistory:DETACH-DATA-SOURCE().
        RETURN.
    END METHOD.
    
END CLASS.
