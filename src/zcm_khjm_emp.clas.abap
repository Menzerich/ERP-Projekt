CLASS zcm_khjm_emp DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF vacation_successfully_approved,
        msgid TYPE symsgid VALUE 'ZKHJM_EMPLOYEE',
        msgno TYPE symsgno VALUE '201',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF VACATION_successfully_approved.

    CONSTANTS:
      BEGIN OF vacation_successfully_declined,
        msgid TYPE symsgid VALUE 'ZKHJM_EMPLOYEE',
        msgno TYPE symsgno VALUE '202',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacation_successfully_declined.

 CONSTANTS:
      BEGIN OF vacation_already_approved,
        msgid TYPE symsgid VALUE 'ZKHJM_EMPLOYEE',
        msgno TYPE symsgno VALUE '401',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF vacation_already_approved.

    CONSTANTS:
      BEGIN OF vacation_already_declined,
        msgid TYPE symsgid VALUE 'ZKHJM_EMPLOYEE',
        msgno TYPE symsgno VALUE '402',
        attr1 TYPE scx_attrname VALUE 'VacReqComment',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF VACATION_already_DECLINED.

    CONSTANTS:
      BEGIN OF not_enough_vacation_days,
        msgid TYPE symsgid VALUE 'ZKHJM_EMPLOYEE',
        msgno TYPE symsgno VALUE '403',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF not_enough_vacation_days.

    CONSTANTS:
      BEGIN OF end_date_before_start_date,
        msgid TYPE symsgid VALUE 'ZKHJM_EMPLOYEE',
        msgno TYPE symsgno VALUE '404',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF end_date_before_start_date.


    "Attributs
    DATA VacReqComment TYPE zkhjm_comment.

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    METHODS constructor
      IMPORTING
        severity      TYPE if_abap_behv_message=>t_severity
        !textid       LIKE if_t100_message=>t100key OPTIONAL
        !previous     LIKE previous OPTIONAL
        VacReqComment TYPE zkhjm_comment OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcm_khjm_emp IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    me->vacreqcomment = vacreqcomment.
    if_abap_behv_message~m_severity = severity.
  ENDMETHOD.



ENDCLASS.
