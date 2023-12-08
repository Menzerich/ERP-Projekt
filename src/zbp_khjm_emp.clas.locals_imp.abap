CLASS lhc_zr_khjm_emp DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.



    METHODS ApproveVacationRequest FOR MODIFY
      IMPORTING keys FOR ACTION VacationRequest~ApproveVacationRequest RESULT result.

    METHODS DeclineVacationRequest FOR MODIFY
      IMPORTING keys FOR ACTION VacationRequest~DeclineVacationRequest RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Employee RESULT result.

    METHODS DetermineVacationRequestStatus FOR DETERMINE ON MODIFY  "Status der Anfrage festlegen
      IMPORTING keys FOR VacationRequest~DetermineVacationRequestStatus.

    METHODS get_instance_authorizations_1 FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR VacationRequest RESULT result.

    METHODS ValidateIfEndBeforeStart FOR VALIDATE ON SAVE    "Validierung Datum
      IMPORTING keys FOR VacationRequest~ValidateIfEndBeforeStart.

    METHODS DetermineResetStatusWhenEdit FOR DETERMINE ON MODIFY "Bereits genehmigter Antrag wird, sobald man editiert wieder auf Requested gesetzt
      IMPORTING keys FOR VacationRequest~DetermineResetStatusWhenEdit.

    METHODS DetermineVacationDays FOR DETERMINE ON MODIFY
      IMPORTING keys FOR VacationRequest~DetermineVacationDays.


ENDCLASS.
CLASS lhc_zr_khjm_emp IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD ApproveVacationRequest.

    DATA message TYPE REF TO zcm_khjm_emp.

    "Read selected vacations request which should be approved
    READ ENTITY IN LOCAL MODE zr_khjm_vac_req
    "fields that are needed -> Status should be changed
    FIELDS ( VacReqStatus VacReqComment )
    WITH CORRESPONDING #( keys )
    RESULT DATA(VacationRequests).

    "Process VacationRequests
    LOOP AT VacationRequests REFERENCE INTO DATA(VacationRequest).

      "Validate Status and Create Error
      IF VacationRequest->VacReqStatus = 'A'.
        message = NEW zcm_khjm_emp(
        "Darstellung für Fehlermeldung
        severity = if_abap_behv_message=>severity-error
        textid = zcm_khjm_emp=>vacation_already_approved
                               vacreqcomment = vacationrequest->VacReqComment ).
        APPEND VALUE #( %tky = VacationRequest->%tky
                        %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest->%tky ) TO failed-vacationrequest.
        DELETE VacationRequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      IF VacationRequest->VacReqStatus = 'D'.
        message = NEW zcm_khjm_emp(
        severity = if_abap_behv_message=>severity-error
        textid = zcm_khjm_emp=>vacation_already_declined
                               vacreqcomment = vacationrequest->VacReqComment ).
        APPEND VALUE #( %tky = VacationRequest->%tky
                        %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest->%tky ) TO failed-vacationrequest.
        DELETE VacationRequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      "Status set on Approved and receive success message
      vacationrequest->VacReqStatus = 'A'.
      message = NEW zcm_khjm_emp(
      "Darstellung als Erfolgsmeldung
      severity = if_abap_behv_message=>severity-success
      textid = zcm_khjm_emp=>vacation_successfully_approved
      vacreqcomment = vacationrequest->VacReqComment ).
      APPEND VALUE #( %tky = vacationrequest->%tky
                      %element = VALUE #(  VacReqStatus = if_abap_behv=>mk-on )
                      %msg = message ) TO reported-vacationrequest.


      "Modify VacationRequests
      MODIFY ENTITY IN LOCAL MODE zr_khjm_vac_req "changing entities
      UPDATE FIELDS ( VacReqStatus ) "Vacation Request Status will be changed
      WITH VALUE #( FOR r IN VacationRequests ( %tky = r-%tky VacReqStatus = r-VacReqStatus ) ).

      "Set result -> Define return for the result
      result = VALUE #( FOR r IN VacationRequests ( %tky = r-%tky %param = r ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD DeclineVacationRequest.

    DATA message TYPE REF TO zcm_khjm_emp.

    "Read selected vacations request which should be declined
    READ ENTITY IN LOCAL MODE zr_khjm_vac_req
        FIELDS ( VacReqStatus VacReqComment )
        WITH CORRESPONDING #(  keys )
        RESULT DATA(VacationRequests).

    "Process VacationRequests
    LOOP AT VacationRequests REFERENCE INTO DATA(VacationRequest).

      "Validate Status and Create Error
      IF VacationRequest->VacReqStatus = 'A'.
        message = NEW zcm_khjm_emp(
        "Represents a error message
        severity = if_abap_behv_message=>severity-error
        "error if you want to decline a vacation request which has already been approved
        textid = zcm_khjm_emp=>vacation_already_approved
            vacreqcomment = vacationrequest->VacReqComment ).
        APPEND VALUE #( %tky = VacationRequest->%tky
                        %element = VALUE #( VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest->%tky ) TO failed-vacationrequest.
        DELETE VacationRequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      "validate Status
      IF VacationRequest->VacReqStatus = 'D'.
        message = NEW zcm_khjm_emp(
        severity = if_abap_behv_message=>severity-error
        "if you try to decline an already declined Vacation Request
        textid = zcm_khjm_emp=>vacation_already_declined
                    vacreqcomment = vacationrequest->VacReqComment ).
        APPEND VALUE #( %tky = VacationRequest->%tky
                            %element = VALUE #( VacReqStatus = if_abap_behv=>mk-on )
                            %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest->%tky ) TO failed-vacationrequest.
        DELETE VacationRequests INDEX sy-tabix.
        CONTINUE.
      ENDIF.

      "Set status to declined and receive a success Message
      vacationrequest->VacReqStatus = 'D'.
      message = NEW zcm_khjm_emp(
      severity = if_abap_behv_message=>severity-success
      textid = zcm_khjm_emp=>vacation_successfully_declined
      vacreqcomment = vacationrequest->VacReqComment ).

      APPEND VALUE #( %tky = vacationrequest->%tky
                      %element = VALUE #( VacReqStatus = if_abap_behv=>mk-on )
                      %msg = message ) TO reported-vacationrequest.

      "Modify VacationRequests
      MODIFY ENTITY IN LOCAL MODE zr_khjm_vac_req
      UPDATE FIELDS ( VacReqStatus )
      WITH VALUE #( FOR r IN VacationRequests ( %tky = r-%tky VacReqStatus = r-VacReqStatus ) ).

      "Set Result
      result = VALUE #( FOR r IN VacationRequests ( %tky = r-%tky %param = r ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD DetermineVacationRequestStatus.

    "Read Vacation Requests
    READ ENTITY IN LOCAL MODE ZR_KHJM_Vac_Req
    FIELDS ( VacReqStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(vacationRequests).

    "Modify Vacation Requests -> Feld status auf Requested setzen
    MODIFY ENTITY IN LOCAL MODE ZR_KHJM_Vac_Req
    UPDATE FIELDS ( VacReqStatus )
    WITH VALUE #( FOR r IN vacationRequests
                      ( %tky = r-%tky
                          VacReqStatus = 'R' ) ).
  ENDMETHOD.

  METHOD get_instance_authorizations_1.
  ENDMETHOD.

  METHOD validateifendbeforestart.
    DATA message TYPE REF TO zcm_khjm_emp.

    READ ENTITY IN LOCAL MODE zr_khjm_vac_req FIELDS ( VacReqStartDate VacReqEndDate ) WITH CORRESPONDING #( keys )
    RESULT DATA(vacationRequests).

    LOOP AT vacationrequests INTO DATA(vacationRequest).
      IF vacationrequest-VacReqEndDate < vacationrequest-VacReqStartDate.
        message = NEW zcm_khjm_emp(
        severity = if_abap_behv_message=>severity-error

        textid = zcm_khjm_emp=>end_date_before_start_date vacreqcomment = vacationrequest-vacreqcomment ).

        APPEND VALUE #( %tky = VacationRequest-%tky
                        %element = VALUE #( VacReqStatus = if_abap_behv=>mk-on )
                        %msg = message ) TO reported-vacationrequest.
        APPEND VALUE #( %tky = VacationRequest-%tky ) TO failed-vacationrequest.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD determineresetstatuswhenedit.
    READ ENTITY IN LOCAL MODE ZR_KHJM_Vac_req
    FIELDS ( VacReqStatus )
    WITH CORRESPONDING #( keys )
    RESULT DATA(vacationRequests).

    LOOP AT vacationRequests REFERENCE INTO DATA(vacationRequest).
      IF vacationrequest->vacReqStatus = 'A'.
        MODIFY ENTITY IN LOCAL MODE zr_khjm_vac_req
         UPDATE FIELDS ( VacReqStatus )
         WITH VALUE #( FOR o IN vacationrequests ( %tky = o-%tky vacreqstatus = 'R' ) ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD determinevacationdays.
    "Read Requests
    READ ENTITY IN LOCAL MODE zr_khjm_vac_req
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(VacationRequests).

    LOOP AT VacationRequests INTO DATA(VacationRequest).

      "Computation Vacation Days
      TRY.
          DATA(calendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( 'SAP_DE_BW' ).
        CATCH cx_fhc_runtime.
          RETURN.
      ENDTRY.


      "Calculate the working days from our RequestStartDate to RequestEndDate
      TRY.
          DATA(working_days) = calendar->calc_workingdays_between_dates( iv_start = vacationrequest-vacreqstartdate iv_end = vacationrequest-vacreqenddate ).
        CATCH cx_fhc_runtime.
          RETURN.
      ENDTRY.

      "Modify VacationRequests
      MODIFY ENTITY IN LOCAL MODE zr_khjm_vac_req
      UPDATE FIELDS ( VacReqDays ) "Vacation Days should be updated
      WITH VALUE #( FOR d IN vacationrequests
      ( %tky = d-%tky
      VacReqDays = working_days + 1 ) ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
