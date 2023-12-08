@EndUserText.label: 'Vacation Request'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_KHJM_VAC_REQ
  as projection on ZR_KHJM_VAC_REQ
{
  key VacationRequestId,
      @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_KHJM_ApproverVH', element: 'EmployeeId'} }]
      @ObjectModel.text.element: [ 'ApplicantName' ]
      VacReqApplicant,
      @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_KHJM_ApproverVH', element: 'EmployeeId'} }]
      @ObjectModel.text.element: [ 'ApproverName' ]
      VacReqApprover,
      VacReqStartDate,
      VacReqEndDate,
      VacReqComment,
      VacReqDays,
      @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_KHJM_StatusVH', element: 'Status'} }]
      @ObjectModel.text.element: [ 'StatusText' ]
      VacReqStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,

      /* Transient Data*/
      ApproverName,
      ApplicantName,
      StatusCriticality,
      StatusText,

      /* Associations */
      _Employee : redirected to parent ZC_KHJM_EMP
}
