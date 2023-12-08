@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Approver'
define view entity ZI_KHJM_ApproverVH
  as select from zkhjm_emp
{
  key id                as EmployeeId,
      employee_number   as EmployeeNumber,
      emp_firstname     as EmpFirstname,
      emp_lastname      as EmpLastname,
      emp_entrance_date as EmpEntranceDate

}
