@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text for Vacation Entitlement Employee'

define view entity ZI_KHJM_VacEntEmployeeText
  as select from zkhjm_emp
{
  key id                                                 as VacationEntEmpId,
      concat_with_space(emp_firstname, emp_lastname , 1) as VacEntEmpName
}
