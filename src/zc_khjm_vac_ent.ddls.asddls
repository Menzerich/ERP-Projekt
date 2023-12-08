@EndUserText.label: 'Vacation Entitlement'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_KHJM_VAC_ENT
  as projection on ZR_KHJM_VAC_ENT
{
  key VacationEntitlementId,

      @ObjectModel.text.element: [ 'VacEntEmpName' ]
      VacEntEmployee,
      VacEntYear,
      VacEntDays,

      CreatedBy,

      CreatedAt,

      LastChangedBy,

      LastChangedAt,

      /* Transient Data*/
      VacEntEmpName,
      VacEntDaysCriticality,



      /* Associations */
      _Employee : redirected to parent ZC_KHJM_EMP
}
