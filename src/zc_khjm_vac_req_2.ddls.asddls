@EndUserText.label: 'Vacation Request 2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@Search.searchable: true

define view entity ZC_KHJM_VAC_REQ_2 as projection on ZR_KHJM_VAC_REQ
{  
    key VacationRequestId,
    @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_KHJM_ApproverVH', element: 'EmployeeId'} }]
    @ObjectModel.text.element: [ 'ApplicantName' ]
    VacReqApplicant,
    @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_KHJM_ApproverVH', element: 'EmployeeId'} }]
    @ObjectModel.text.element: ['ApproverName']
    VacReqApprover,
    VacReqStartDate,
    VacReqEndDate,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    VacReqComment,
    VacReqDays,
    @Consumption.valueHelpDefinition: [{ entity: {name: 'ZI_KHJM_StatusVH', element: 'Status'} }]
    @ObjectModel.text.element: [ 'StatusText' ]
    VacReqStatus,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    ApplicantName,
    ApproverName,
    StatusText,
    StatusCriticality,
    /* Associations */
    _Employee : redirected to parent ZC_KHJM_EMP_2
}
