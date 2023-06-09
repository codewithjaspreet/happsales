class Globals {
  static String USER_TOKEN = "";
  static String USER_TOKEN_ALT = "";
  static String AppUserLoginName = "";
  static String AppUserName = "";
  static String AppUserEmail = "";
  static int AppUserID = (-1);
  static int AppUserGroupID = (-1);
  static String AppUserGroupName = "";
  static bool AppUserObjectChanged = false;
  static int MAX_UPSYNC_INDEX = 5;
  static int GPS_TRACKER_INTERVAL_MINUTES = 5;
  static int GPS_TRACKER_INTERVAL_SECONDS = (GPS_TRACKER_INTERVAL_MINUTES * 60);
  static int GPS_TRACKER_INTERVAL_MILLISECONDS =
      (GPS_TRACKER_INTERVAL_SECONDS * 1000);
  static int CHAT_DEFAULT_SYNC_INTERVAL = (30 * 1000);
  static int CHAT_CURRENT_APPUSERID = 0;
  static String CHAT_CURRENT_GROUPUID = "";
  static String CHAT_USERANDGROUP_ID_SELF = "";
  static String CHAT_USERANDGROUP_ID_AMI = "";
  static bool CHAT_MUTE = false;
  static bool BACKGROUND_LOCATION = false;
  static bool EnableSyncService = true;
  static String AppUserUID = "";
  static String AppUserGroupUID = "";
  static bool USER_LOGGED_IN = false;
  static String UserName = "";
  static String Email = "";
  static String PhoneNumber = "";
  static String DeviceIdentifier = "";
  static String CurrencyID = "";
  static String CurrencySymbol = "";
  static String ClientUrl = "";
  static String GalleryPath = "";
  static double Latitude = 0;
  static double Longitude = 0;
  static String LocationAddress = "";
  static String AccountIdForIndividual = "";
  static int SyncIndex = 1;
  static int SyncIndexApplog = 1;

  // static ArrayList UpSyncList = new ArrayList();
  // static ArrayList<OpportunityProductModel> OpportunityProductsSelected = new ArrayList<OpportunityProductModel>();
  // static ArrayList<ActivityProductModel> ActivityProductsSelected = new ArrayList<ActivityProductModel>();
  // static ArrayList<ActivityTravelExpense> ActivityTravelExpenseSelected = new ArrayList<ActivityTravelExpense>();

  static int ActiveAccountId = (-1);
  static String ActiveAccountName = "";
  static int ActiveServerAccountId = (-1);
  static int ActiveContactId = (-1);
  static int ActiveOpportunityId = (-1);
  static int ActiveActivityId = (-1);
  static bool AddingAccount = false;
  static bool AddingMediaContent = false;
  static bool DoingBusinessCardScan = false;
  static String ActiveMediaContent = "";
  static String ActiveMediaFileName = "";
  static bool GoBackToPreviousPage = false;

  // static ArrayList<String> Account_FilterList = new ArrayList<String>();
  // static ArrayList<String> Contact_FilterList = new ArrayList<String>();
  // static ArrayList<String> Activity_FilterList = new ArrayList<String>();
  // static ArrayList<String> Opportunity_FilterList = new ArrayList<String>();
  // static ArrayList<String> Note_FilterList = new ArrayList<String>();

  static String DownSyncStatus = "";
  static String DownSyncCountStatus = "";
  static String UpSyncStatus = "";
  static String UpSyncCountStatus = "";
  static String ErrorStatus = "";
  static bool showProductsSelection = true;
  static bool isLocationFetching = false;
  static String ENCRYPTION_KEY = "2hAfEsA\$2a975ei!";
  static String locationAddress = "";

 static String getStringValue(Object obj) {
    if (obj.toString() == "null") {
      return "";
    } else {
      return obj.toString();
    }
  }

  static  tryParseLongForDBId(Object obj) {
  String retVal = "";
  try {
    int retVal2 = int.parse(obj.toString());
    retVal = retVal2.toString();
  } catch (e) {
    retVal = "-1"; // or null if preferred
  }
  return retVal;
}

}
