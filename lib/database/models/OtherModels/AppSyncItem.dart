class AppSyncItem{


String?  _id;
    String?  _tableName;
    String?  _lMaxDate;
    String?  _sMaxDate;
    String?  _pgSize;
    String?  _records;
    String?  _page;
    
    String?  _syncTime;


    //getters
    String? get id => _id;
    String? get tableName => _tableName;
    String? get lMaxDate => _lMaxDate;
    String? get sMaxDate => _sMaxDate;
    String? get pgSize => _pgSize;
    String? get records => _records;
    String? get page => _page;
    String? get syncTime => _syncTime;


    //setters

    set id(String? id){
      _id = id;
    }

    set tableName(String? tableName){
      _tableName = tableName;
    }

    set lMaxDate(String? lMaxDate){
      _lMaxDate = lMaxDate;
    }

    set sMaxDate(String? sMaxDate){
      _sMaxDate = sMaxDate;
    }

    set pgSize(String? pgSize){
      _pgSize = pgSize;
    }

    set records(String? records){
      _records = records;
    }

    set page(String? page){
      _page = page;
    }

    set syncTime(String? syncTime){
      _syncTime = syncTime;
    }

    
}
