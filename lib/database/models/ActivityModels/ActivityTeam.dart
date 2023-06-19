import 'package:happsales_crm/database/models/ActivityModels/ActivityTeamBase.dart';

class ActivityTeam extends ActivityTeamBase{

     String? _AppUserName;
     String?_Designation;

     // getter and setters for both

      String? get AppUserName => _AppUserName;
      String? get Designation => _Designation;

      set AppUserName(String? AppUserName) => _AppUserName = AppUserName;
      set Designation(String? Designation) => _Designation = Designation;

    ActivityTeam();
}