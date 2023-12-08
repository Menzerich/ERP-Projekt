@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employees'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_KHJM_EMP
  provider contract transactional_query
  as projection on ZR_KHJM_EMP
{
  key EmployeeId,
      EmployeeNumber,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      EmpFirstName,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      EmpLastName,

      EmpEntranceDate,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,


      /* Associations */
      _VacationEntitlements : redirected to composition child ZC_KHJM_VAC_ENT,
      _VacationRequests     : redirected to composition child ZC_KHJM_VAC_REQ
}
