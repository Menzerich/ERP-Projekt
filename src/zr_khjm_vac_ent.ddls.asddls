@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vacation Entitlement'
define view entity ZR_KHJM_VAC_ENT
  as select from zkhjm_vac_ent
  association        to parent ZR_KHJM_EMP         as _Employee      on $projection.VacEntEmployee = _Employee.EmployeeId
  association [1..1] to ZI_KHJM_VacEntEmployeeText as _VacEntEmpText on $projection.VacEntEmployee = _VacEntEmpText.VacationEntEmpId
{
      @EndUserText: {label: 'Vacation Entitlement UUID', quickInfo: 'Vacation Entitlement UUID'}
  key id                           as VacationEntitlementId, //VacationEntitlementId
      @EndUserText: {label: 'Employee UUID', quickInfo: 'Employee UUID'}
      employee                     as VacEntEmployee,
      vac_ent_year                 as VacEntYear,
      vac_ent_days                 as VacEntDays,
      @Semantics.user.createdBy: true
      created_by                   as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                   as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by              as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at              as LastChangedAt,




      /* Transient Data */
      _VacEntEmpText.VacEntEmpName as VacEntEmpName,
      case  when vac_ent_days <=10 then 1
            when vac_ent_days >=11 then 3
            else 0
            end                    as VacEntDaysCriticality,

      /* Associations */
      _Employee
}
