import 'OpportunityTeamBase.dart';

class OpportunityTeam extends OpportunityTeamBase{

     String? _appUserName;
   String? _designation;

   //getters

    String? get appUserName => _appUserName;
    String? get designation => _designation;

    //setters

    set appUserName(String? value) {
      _appUserName = value;
    }

    set designation(String? value) {
      _designation = value;
    }

OpportunityTeam();
}