@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee'
define root view entity ZR_KHJM_EMP
  as select from zkhjm_emp
  composition [0..*] of ZR_KHJM_VAC_ENT as _VacationEntitlements
  composition [0..*] of ZR_KHJM_VAC_REQ as _VacationRequests


{
      @EndUserText: {label: 'Employee UUID', quickInfo: 'Employee UUID'}
  key id                as EmployeeId, //EmployeeId
      employee_number   as EmployeeNumber,
      emp_firstname     as EmpFirstName,
      emp_lastname      as EmpLastName,
      emp_entrance_date as EmpEntranceDate,
      @Semantics.user.createdBy: true
      created_by        as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at        as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by   as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at   as LastChangedAt,




      /*Association*/
      // Make association public
      _VacationEntitlements,
      _VacationRequests
}
