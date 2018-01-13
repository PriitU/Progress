 
 /*------------------------------------------------------------------------
    File        : beContract
    Syntax      : 
    Author(s)   : IEUser
    Created     : Tue Jan 02 10:50:10 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="beContract.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="beContract", URI="/beContract", schemaName="dsContract", schemaFile="Progress-master/src/AppServer/becontract.i").

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS beContract:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"src\AppServer\becontract.i"}
    
    DEFINE DATA-SOURCE srcContract FOR data2.Contract.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadbeContract(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsContract):
        
        DEFINE VARIABLE pcWhere AS CHARACTER.
        pcWhere = "".
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
    METHOD PUBLIC VOID CreatebeContract(INPUT-OUTPUT DATASET dsContract):                                  
    
        THIS-OBJECT:CommitbeContract(INPUT "", INPUT ROW-CREATED).        
        RETURN.        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdatebeContract(INPUT-OUTPUT DATASET dsContract):            
    
    
        THIS-OBJECT:CommitbeContract(INPUT "", INPUT ROW-MODIFIED).
                      
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeletebeContract(INPUT-OUTPUT DATASET dsContract):                    
    
    
        THIS-OBJECT:CommitbeContract(INPUT "", INPUT ROW-DELETED).
        
    END METHOD.
     
    
    /*------------------------------------------------------------------------------
            Purpose:  generic routine for creating/updating/deleting customers                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID commitbeContract(
                    INPUT pcFieldMapping AS CHARACTER,
                    INPUT piRowState AS INTEGER ):
        DEFINE VARIABLE Skip-list AS CHARACTER NO-UNDO.
        BUFFER ttContract:ATTACH-DATA-SOURCE (DATA-SOURCE srcContract:HANDLE,
                                             pcFieldMapping).
        FOR EACH ttContract.
            BUFFER ttContract:MARK-ROW-STATE (piRowState). 
        END.
        IF piRowState = ROW-CREATED THEN
            Skip-list  = "ContractId".
        FOR EACH bttContract:
            BUFFER bttContract:SAVE-ROW-CHANGES(1, Skip-list).
        END.
        FINALLY:
            BUFFER ttContract:DETACH-DATA-SOURCE().
        END FINALLY.
    END METHOD.
    /*------------------------------------------------------------------------------
            Purpose:  Generic routine for FILL method on gets/load                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID applyFillMethod(INPUT pcWhere AS CHARACTER):
        
        /* get rid of any existing data */
        EMPTY TEMP-TABLE ttContract.
        BUFFER ttContract:ATTACH-DATA-SOURCE(DATA-SOURCE srcContract:HANDLE).
        //IF pcWhere NE "" THEN 
        //    DATA-SOURCE srcContract:FILL-WHERE-STRING = pcWhere.
        DATASET dsContract:FILL().
        BUFFER ttContract:DETACH-DATA-SOURCE().
        RETURN.
    END METHOD.
    
END CLASS.
