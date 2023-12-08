@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vacation Request'
define view entity ZR_KHJM_VAC_REQ
  as select from zkhjm_vac_req
  association        to parent ZR_KHJM_EMP       as _Employee         on $projection.VacReqApplicant = _Employee.EmployeeId
  association [1..1] to ZI_KHJM_VACAPPLICANTTEXT as _VacApplicantText on $projection.VacReqApplicant = _VacApplicantText.VacationApplicantId
  association [1..1] to ZI_KHJM_VacApproverText  as _VacApproverText  on $projection.VacReqApprover = _VacApproverText.VacationApproverId
  association [1..1] to ZI_KHJM_StatusText       as _StatusText       on $projection.VacationRequestId = _StatusText.VacationRequestId
{
      @EndUserText: {label: 'Vacation Request ID', quickInfo: 'Vacation Request Id'}
  key id                              as VacationRequestId, //VacationRequestId

      @EndUserText: {label: 'Applicant', quickInfo: 'Vacation Request Employee UUID'}
      applicant                       as VacReqApplicant,

      @EndUserText: {label: 'Approver', quickInfo: 'Vacation Request Approver UUID'}
      vac_req_approver                as VacReqApprover,
      vac_req_start_date              as VacReqStartDate,
      vac_req_end_date                as VacReqEndDate,
      vac_req_comment                 as VacReqComment,
      vac_req_status                  as VacReqStatus,
      vac_req_days                    as VacReqDays,
      @Semantics.user.createdBy: true
      created_by                      as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                      as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                 as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                 as LastChangedAt,

      /*Transient Data*/
      _VacApplicantText.ApplicantName as ApplicantName,
      _VacApproverText.ApproverName   as ApproverName,
      
      case when vac_req_status = 'A' then _StatusText.StatusNameA 
        when vac_req_status = 'D' then _StatusText.StatusNameD 
        when vac_req_status = 'R' then _StatusText.StatusNameR 
        else null
        end as StatusText,
      
      case when vac_req_status ='A' then 3
      when vac_req_status ='R' then 2
      when vac_req_status ='D' then 1
      else 0
      end                             as StatusCriticality,

      /*Associations*/
      _Employee



}
