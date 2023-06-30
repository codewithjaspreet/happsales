import 'AppUserBase.dart';

class AppUser extends AppUserBase{


    String? ReportingTo1Email;

    String? ReportingTo1Phone;

    String? ReportingTo1Designation;

    String? ReportingTo2Email;

    String? ReportingTo2Phone;

    String? ReportingTo2Designation;

    String? ReportingTo3Email;

    String? ReportingTo3Phone;

    String? ReportingTo3Designation;

    String? UserModules;

    String? UserPermissions;

    String? UserToken;

    String? MuteChat;


    //getters and setters

    String? get reportingTo1Email => ReportingTo1Email;
    set reportingTo1Email(String? reportingTo1Email){
      ReportingTo1Email = reportingTo1Email;
    }

    String? get reportingTo1Phone => ReportingTo1Phone;

    set reportingTo1Phone(String? reportingTo1Phone){
      ReportingTo1Phone = reportingTo1Phone;
    }

    String? get reportingTo1Designation => ReportingTo1Designation;

    set reportingTo1Designation(String? reportingTo1Designation){
      ReportingTo1Designation = reportingTo1Designation;
    }

    String? get reportingTo2Email => ReportingTo2Email;

    set reportingTo2Email(String? reportingTo2Email){
      ReportingTo2Email = reportingTo2Email;
    }

    String? get reportingTo2Phone => ReportingTo2Phone;

    set reportingTo2Phone(String? reportingTo2Phone){
      ReportingTo2Phone = reportingTo2Phone;
    }

    String? get reportingTo2Designation => ReportingTo2Designation;

    set reportingTo2Designation(String? reportingTo2Designation){
      ReportingTo2Designation = reportingTo2Designation;
    }

    String? get reportingTo3Email => ReportingTo3Email;

    set reportingTo3Email(String? reportingTo3Email){
      ReportingTo3Email = reportingTo3Email;
    }

    String? get reportingTo3Phone => ReportingTo3Phone;

    set reportingTo3Phone(String? reportingTo3Phone){
      ReportingTo3Phone = reportingTo3Phone;
    }

    String? get reportingTo3Designation => ReportingTo3Designation;



    set reportingTo3Designation(String? reportingTo3Designation){
      ReportingTo3Designation = reportingTo3Designation;
    }


    String? get userModules => UserModules;

    set userModules(String? userModules){
      UserModules = userModules;
    }

    String? get userPermissions => UserPermissions;

    set userPermissions(String? userPermissions){
      UserPermissions = userPermissions;
    }

    String? get userToken => UserToken;

    set userToken(String? userToken){
      UserToken = userToken;
    }

    String? get muteChat => MuteChat;

    set muteChat(String? muteChat){
      MuteChat = muteChat;
    }

    


  AppUser();
}