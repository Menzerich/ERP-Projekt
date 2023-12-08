@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Text for Status'

define view entity ZI_KHJM_StatusText as select from zkhjm_vac_req
{
 key id as VacationRequestId,
 vac_req_status as VacReqStatus,
 
 'Declined' as StatusNameD,
 'Approved' as StatusNameA,
 'Requested' as StatusNameR
 
}
