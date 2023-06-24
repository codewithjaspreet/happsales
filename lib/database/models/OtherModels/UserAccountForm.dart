import '../AccountModels/AccountForm.dart';
import '../AccountModels/AccountFormValue.dart';

class UserAccountForm {
  AccountForm accountForm;
  List<AccountFormValue> accountFormValues;

  UserAccountForm()
      : accountForm = AccountForm(),
        accountFormValues = [];
}