import 'ResourceBase.dart';

class Resource extends ResourceBase{

       String ? _resourceCategoryName;
//getter
String ? get resourceCategoryName => _resourceCategoryName;

//setter

set resourceCategoryName(String ? resourceCategoryName){

  _resourceCategoryName = resourceCategoryName;

}


  Resource();
}
