import 'package:happsales_crm/database/models/OpportunityModels/OpportunityBase.dart';

class Opportunity extends OpportunityBase{

  String? _workFlowDetails;


  // getter
  String? get workFlowDetails => _workFlowDetails;
  //setter
  set workFlowDetails(String? workFlowDetails) => _workFlowDetails = workFlowDetails;

 

  Opportunity();
}