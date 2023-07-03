import 'package:happsales_crm/database/models/OtherModels/ChatUserGroupMemberBase.dart';

class ChatUserGroupMember extends ChatUserGroupMemberBase{



     String? MemberName;
     String? MemberDescription;
     String? PhoneNumber;
     String? Email;


     //setter and getters for all

      //getter


      String? get memberName => MemberName;
      String? get memberDescription => MemberDescription;
      String? get phoneNumber => PhoneNumber;
      String? get email => Email;


      //setter



      set memberName(String? memberName) => MemberName = memberName;
      set memberDescription(String? memberDescription) => MemberDescription = memberDescription;
      set phoneNumber(String? phoneNumber) => PhoneNumber = phoneNumber;
      set email(String? email) => Email = email;
      


    ChatUserGroupMember();
}