@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text for Vacation Request Approver'

define view entity ZI_KHJM_VacApproverText
  as select from zkhjm_emp
{
  key id                                                as VacationApproverId,
      concat_with_space(emp_firstname, emp_lastname, 1) as ApproverName
}
