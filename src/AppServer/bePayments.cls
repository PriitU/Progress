 
 /*------------------------------------------------------------------------
    File        : bePayments
    Syntax      : 
    Author(s)   : IEUser
    Created     : Tue Jan 02 11:19:10 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="bePayments.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="bePayments", URI="/bePayments", schemaName="dsPaymentHistory", schemaFile="Progress-master/src/AppServer/bepayments.i").

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS bePayments:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"src\AppServer\bepayments.i"}
    
    DEFINE DATA-SOURCE srcPaymentHistory FOR data2.PaymentHistory.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadbePayments(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsPaymentHistory):
        
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
    METHOD PUBLIC VOID CreatebePayments(INPUT-OUTPUT DATASET dsPaymentHistory):                                  
    
        THIS-OBJECT:CommitbePayments(INPUT "", INPUT ROW-CREATED).        
        RETURN.        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdatebePayments(INPUT-OUTPUT DATASET dsPaymentHistory):            
    
    
        THIS-OBJECT:CommitbePayments(INPUT "", INPUT ROW-MODIFIED).
                      
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeletebePayments(INPUT-OUTPUT DATASET dsPaymentHistory):                    
    
    
        THIS-OBJECT:CommitbePayments(INPUT "", INPUT ROW-DELETED).
        
    END METHOD.
     
    
    /*------------------------------------------------------------------------------
            Purpose:  generic routine for creating/updating/deleting customers                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID commitbePayments(
                    INPUT pcFieldMapping AS CHARACTER,
                    INPUT piRowState AS INTEGER ):
        DEFINE VARIABLE Skip-list AS CHARACTER NO-UNDO.
        BUFFER ttPaymentHistory:ATTACH-DATA-SOURCE (DATA-SOURCE srcPaymentHistory:HANDLE,
                                             pcFieldMapping).
        FOR EACH ttPaymentHistory.
            BUFFER ttPaymentHistory:MARK-ROW-STATE (piRowState). 
        END.
        IF piRowState = ROW-CREATED THEN
            Skip-list  = "PaymentHistoryId".
        FOR EACH bttPaymentHistory:
            BUFFER bttPaymentHistory:SAVE-ROW-CHANGES(1, Skip-list).
        END.
        FINALLY:
            BUFFER ttPaymentHistory:DETACH-DATA-SOURCE().
        END FINALLY.
    END METHOD.
    /*------------------------------------------------------------------------------
            Purpose:  Generic routine for FILL method on gets/load                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID applyFillMethod(INPUT pcWhere AS CHARACTER):
        
        /* get rid of any existing data */
        EMPTY TEMP-TABLE ttPaymentHistory.
        BUFFER ttPaymentHistory:ATTACH-DATA-SOURCE(DATA-SOURCE srcPaymentHistory:HANDLE).
        //IF pcWhere NE "" THEN 
        //    DATA-SOURCE srcPaymentHistory:FILL-WHERE-STRING = pcWhere.
        DATASET dsPaymentHistory:FILL().
        BUFFER ttPaymentHistory:DETACH-DATA-SOURCE().
        RETURN.
    END METHOD.
    
END CLASS.
