@EndUserText.label: 'Employees2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_KHJM_EMP_2
  provider contract transactional_query as projection on ZR_KHJM_EMP
{
    key EmployeeId,
    EmployeeNumber,
    EmpFirstName,
    EmpLastName,
    EmpEntranceDate,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    /* Associations */
    _VacationRequests : redirected to composition child ZC_KHJM_VAC_REQ_2
}
