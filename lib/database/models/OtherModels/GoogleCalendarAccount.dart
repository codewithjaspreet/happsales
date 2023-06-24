class GoogleCalendarAccount{


  String? _calendarAccountName;
  int?  _calendarAccountID;

  //getters and setters

  String? get calendarAccountName => _calendarAccountName;
  set calendarAccountName(String? value) {
    _calendarAccountName = value;
  }

  int? get calendarAccountID => _calendarAccountID;

  set calendarAccountID(int? value) {
    _calendarAccountID = value;
  }
  
}