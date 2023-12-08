@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text for Vacation Applicant'


define view entity ZI_KHJM_VACAPPLICANTTEXT
  as select from zkhjm_emp
{
  key id                                                 as VacationApplicantId,
      concat_with_space(emp_firstname, emp_lastname , 1) as ApplicantName
}
