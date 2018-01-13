 
 /*------------------------------------------------------------------------
    File        : beCustomer
    Syntax      : 
    Author(s)   : IEUser
    Created     : Tue Jan 02 11:18:36 PST 2018
    Notes       : 
  ----------------------------------------------------------------------*/
  
@program FILE(name="beCustomer.cls", module="AppServer").
@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="beCustomer", URI="/beCustomer", schemaName="dsCustomer", schemaFile="Progress-master/src/AppServer/becustomer.i").

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS beCustomer:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"src\AppServer\becustomer.i"}
    
    @openapi.openedge.entity.primarykey (fields="CustomerId").
    @openapi.openedge.entity.required (fields="CustomerId").

    
    
    DEFINE DATA-SOURCE srcCustomer FOR data2.Customer.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json"). 
    METHOD PUBLIC VOID ReadbeCustomer(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsCustomer):
        
        DEFINE VARIABLE pcWhere AS CHARACTER.
        IF filter BEGINS "WHERE " THEN
            pcWhere = filter.
        ELSE
            //pcWhere = "WHERE " + filter.              
            pcWhere = "".
        THIS-OBJECT:applyFillMethod (INPUT pcWhere).       
        RETURN.          
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/  
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="create", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID CreatebeCustomer(INPUT-OUTPUT DATASET dsCustomer):                                  
    
        THIS-OBJECT:CommitbeCustomer(INPUT "", INPUT ROW-CREATED).        
        RETURN.        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="update", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID UpdatebeCustomer(INPUT-OUTPUT DATASET dsCustomer):            
    
    
        THIS-OBJECT:CommitbeCustomer(INPUT "", INPUT ROW-MODIFIED).
                      
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="true").
    @progress.service.resourceMapping(type="REST", operation="delete", URI="", alias="", mediaType="application/json").
    METHOD PUBLIC VOID DeletebeCustomer(INPUT-OUTPUT DATASET dsCustomer):                    
    
       
        THIS-OBJECT:CommitbeCustomer(INPUT "", INPUT ROW-DELETED).

        
    END METHOD.
     
    
    /*------------------------------------------------------------------------------
            Purpose:  generic routine for creating/updating/deleting customers                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID commitbeCustomer(
                    INPUT pcFieldMapping AS CHARACTER,
                    INPUT piRowState AS INTEGER ):
        DEFINE VARIABLE Skip-list AS CHARACTER NO-UNDO.
        BUFFER ttCustomer:ATTACH-DATA-SOURCE (DATA-SOURCE srcCustomer:HANDLE,
                                             pcFieldMapping).
        FOR EACH ttCustomer.
            BUFFER ttCustomer:MARK-ROW-STATE (piRowState). 
        END.
        IF piRowState = ROW-CREATED THEN
            Skip-list  = "CustomerId".
        FOR EACH bttCustomer:
            BUFFER bttCustomer:SAVE-ROW-CHANGES(1, Skip-list).
        END.
        FINALLY:
            BUFFER ttCustomer:DETACH-DATA-SOURCE().
        END FINALLY.
    END METHOD.
    /*------------------------------------------------------------------------------
            Purpose:  Generic routine for FILL method on gets/load                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PRIVATE VOID applyFillMethod(INPUT pcWhere AS CHARACTER):
        
        /* get rid of any existing data */
        EMPTY TEMP-TABLE ttCustomer.
        BUFFER ttCustomer:ATTACH-DATA-SOURCE(DATA-SOURCE srcCustomer:HANDLE).
        //IF pcWhere NE "" THEN 
        //    DATA-SOURCE srcCustomer:FILL-WHERE-STRING = pcWhere.
        DATASET dsCustomer:FILL().
        BUFFER ttCustomer:DETACH-DATA-SOURCE().
        RETURN.
    END METHOD.
    
END CLASS.
