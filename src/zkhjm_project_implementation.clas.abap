CLASS zkhjm_project_implementation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
       INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZKHJM_PROJECT_IMPLEMENTATION IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA employees TYPE TABLE OF ZKHJM_EMP.
    DATA employee TYPE ZKHJM_EMP.

    DATA entitlements TYPE TABLE OF ZKHJM_VAC_ENT.
    DATA entitlement TYPE ZKHJM_VAC_ENT.

    DATA requests TYPE TABLE OF ZKHJM_VAC_REQ.
    DATA request TYPE ZKHJM_VAC_REQ.

    "Datenbanktabellen löschen
    DELETE FROM ZKHJM_EMP.
    DELETE FROM ZKHJM_VAC_ENT.
    DELETE FROM ZKHJM_VAC_REQ.

    "Draft Tabellen löschen
    DELETE FROM ZKHJM_EMP_DRAFT.
    DELETE FROM ZKHJM_VAC_ENT_DR.
    DELETE FROM ZKHJM_VAC_REQ_DR.


"Eintrag 1 (Hans)
    data hans type String.
    hans = cl_system_uuid=>create_uuid_x16_static( ).
    employee-id = hans.
    employee-employee_number = 1.
    employee-client = sy-mandt.
    employee-emp_firstname = 'Hans'.
    employee-emp_lastname = 'Maier'.
    employee-emp_entrance_date = '20000501'.
    employee-created_by = 'Jonas Menz'.             "Name schreiben oder lieber Generator?
    GET TIME STAMP FIELD employee-created_at.
    employee-last_changed_by = 'Jonas Menz'.
    GET TIME STAMP FIELD employee-last_changed_at.
    append employee TO employees.

    "Eintrag 2 (Lisa)
    data lisa type String.
    lisa = cl_system_uuid=>create_uuid_x16_static(  ).
    employee-id = lisa.
    employee-employee_number = 2.
    employee-client = sy-mandt.
    employee-emp_firstname = 'Lisa'.
    employee-emp_lastname = 'Müller'.
    employee-emp_entrance_date = '20100701'.
    employee-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD employee-created_at.
    employee-last_changed_by = 'Jonas Menz'.
    GET TIME STAMP FIELD employee-last_changed_at.
    append employee TO employees.

    "Eintrag 3 (Petra)
    data petra type String.
    petra = cl_system_uuid=>create_uuid_x16_static( ).
    employee-id = petra.
    employee-employee_number = 3.
    employee-client = sy-mandt.
    employee-emp_firstname = 'Petra'.
    employee-emp_lastname = 'Schmid'.
    employee-emp_entrance_date = '20231001'.
    employee-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD employee-created_at.
    employee-last_changed_by = 'Jonas Menz'.
    GET TIME STAMP FIELD employee-last_changed_at.
    append employee TO employees.

"Urlaubsansprüche

"Urlaubsanspruch Hans 2022
    entitlement-client = sy-mandt.
    entitlement-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD entitlement-created_at.
    entitlement-last_changed_by = 'Jonas Menz'.
    GET TIME STAMP FIELD entitlement-last_changed_at.
    entitlement-vac_ent_year = '2022'.
    entitlement-vac_ent_days = '30'. "Sollte 30 stehen
    entitlement-employee = hans.
    entitlement-id = cl_system_uuid=>create_uuid_x16_static( ).
    append entitlement TO entitlements.

    "Urlaubsanspruch Hans 2023
    entitlement-client = sy-mandt.
    entitlement-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD entitlement-created_at.
    entitlement-last_changed_by = 'Jonas Menz'.
    GET TIME STAMP FIELD entitlement-last_changed_at.
    entitlement-vac_ent_year = '2023'.
    entitlement-vac_ent_days = '30'.
    entitlement-employee = hans.
    entitlement-id = cl_system_uuid=>create_uuid_x16_static( ).
    append entitlement TO entitlements.

    "Urlaubsanspruch Lisa 2023
    entitlement-client = sy-mandt.
    entitlement-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD entitlement-created_at.
    entitlement-last_changed_by = 'Jonas Menz'.
    GET TIME STAMP FIELD entitlement-last_changed_at.
    entitlement-vac_ent_year = '2023'.
    entitlement-vac_ent_days = '30'.
    entitlement-employee = lisa.
    entitlement-id = cl_system_uuid=>create_uuid_x16_static( ).
    append entitlement TO entitlements.

    "Urlaubsanspruch Petra 2023
    entitlement-client = sy-mandt.
    entitlement-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD entitlement-created_at.
    entitlement-last_changed_by = 'Jonas Menz'.
    GET TIME STAMP FIELD entitlement-last_changed_at.
    entitlement-vac_ent_year = '2023'.
    entitlement-vac_ent_days = '7'.
    entitlement-employee = petra.
    entitlement-id = cl_system_uuid=>create_uuid_x16_static( ).
    append entitlement TO entitlements.

"Urlaubsanträge

    "Urlaubsantrag 1 Hans Sommerurlaub
    request-client = sy-mandt.
    request-id = cl_system_uuid=>create_uuid_x16_static( ).
    request-applicant = hans.
    request-vac_req_approver = lisa.            "hier zuvor Lisa Müller gestanden
    GET TIME STAMP FIELD request-created_at.
    request-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD request-last_changed_at.
    request-last_changed_by = 'Jonas Menz'.
    request-vac_req_start_date = '20220701'.
    request-vac_req_end_date = '20220710'.
    request-vac_req_comment = 'Sommerurlaub'.
    request-vac_req_status = 'A'.
    request-vac_req_days = '6'.
    append request TO requests.

    "Urlaubsantrag 2 Hans Weihnachtsurlaub
    request-client = sy-mandt.
    request-id = cl_system_uuid=>create_uuid_x16_static( ).
    request-applicant = hans.
    request-vac_req_approver = lisa.
    GET TIME STAMP FIELD request-created_at.
    request-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD request-last_changed_at.
    request-last_changed_by = 'Jonas Menz'.
    request-vac_req_start_date = '20221227'.
    request-vac_req_end_date = '20221230'.
    request-vac_req_comment = 'Weihnachtsurlaub'.
    request-vac_req_status = 'D'.
    request-vac_req_days = '4'.
    append request TO requests.

    "Urlaubsantrag 3 Hans Weihnachtsurlaub 2. Versuch
    request-client = sy-mandt.
    request-id = cl_system_uuid=>create_uuid_x16_static( ).
    request-applicant = hans.
    request-vac_req_approver = lisa.
    GET TIME STAMP FIELD request-created_at.
    request-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD request-last_changed_at.
    request-last_changed_by = 'Jonas Menz'.
    request-vac_req_start_date = '20221228'.
    request-vac_req_end_date = '20221230'.
    request-vac_req_comment = 'Weihnachtsurlaub (2.Versuch)'.
    request-vac_req_status = 'A'.
    request-vac_req_days = '3'.
    append request TO requests.

    "Urlaubsantrag 4 Hans Bereits genehmigt
    request-client = sy-mandt.
    request-id = cl_system_uuid=>create_uuid_x16_static( ).
    request-applicant = hans.
    request-vac_req_approver = lisa.
    GET TIME STAMP FIELD request-created_at.
    request-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD request-last_changed_at.
    request-last_changed_by = 'Jonas Menz'.
    request-vac_req_start_date = '20230527'.
    request-vac_req_end_date = '20230614'.
    request-vac_req_comment = ' '.
    request-vac_req_status = 'A'.
    request-vac_req_days = '3'.
    append request TO requests.

    "Urlaubsantrag 5 Hans Winterurlaub
    request-client = sy-mandt.
    request-id = cl_system_uuid=>create_uuid_x16_static( ).
    request-applicant = hans.
    request-vac_req_approver = lisa.
    GET TIME STAMP FIELD request-created_at.
    request-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD request-last_changed_at.
    request-last_changed_by = 'Jonas Menz'.
    request-vac_req_start_date = '20231220'.
    request-vac_req_end_date = '20231231'.
    request-vac_req_comment = 'Winterurlaub'.
    request-vac_req_status = 'R'.
    request-vac_req_days = '6'.
    append request TO requests.

    "Urlaubsantrag Petra Weihnachtsurlaub
    request-client = sy-mandt.
    request-id = cl_system_uuid=>create_uuid_x16_static( ).
    request-applicant = petra.
    request-vac_req_approver = hans.
    GET TIME STAMP FIELD request-created_at.
    request-created_by = 'Jonas Menz'.
    GET TIME STAMP FIELD request-last_changed_at.
    request-last_changed_by = 'Jonas Menz'.
    request-vac_req_start_date = '20231227'.
    request-vac_req_end_date = '20231231'.
    request-vac_req_comment = 'Weihnachtsurlaub'.
    request-vac_req_status = 'R'.
    request-vac_req_days = '3'.
    append request TO requests.



    INSERT ZKHJM_EMP FROM TABLE @employees.
    INSERT ZKHJM_VAC_ENT FROM TABLE @entitlements.
    INSERT ZKHJM_VAC_REQ FROM TABLE @requests.


  ENDMETHOD.
ENDCLASS.


