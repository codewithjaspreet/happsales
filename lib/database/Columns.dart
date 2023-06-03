/*************************************************************************
 *
 * HAPPSALES CONFIDENTIAL
 * ____________________________________
 *
 *  [2019-23] HappSales Private Limited
 *  www.happsales.com
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains the property of HappSales Private Limited.
 * The intellectual and technical concepts contained herein are proprietary to HappSales Private Limited
 * and  are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material is strictly forbidden unless prior
 * written permission is obtained from HappSales Private Limited.
 */

//////////////////////////////////////////////////////////////////////////////////////////////////
// Class Name    : Columns
// Created By    : Vijay Kumar Vettath
// Created Date  : Nov-2019
// Purpose       : Class for defining additional columns
// Details       : This class defined additional columns in the app database
// Change History:- 
// Date:      
// Author:
// Change: 
//////////////////////////////////////////////////////////////////////////////////////////////////

import 'ColumnsBase.dart';

 class Columns extends ColumnsBase {

     static const String KEY_APPUSER_TOKEN = "UserToken";

     static const String KEY_ACCOUNT_SUPPLIERACCOUNTNAME = "SupplierAccountName";

     static const String KEY_PRODUCT_AUXILIARYPRODUCTNAME = "ProductName";

     static const String KEY_ACCOUNTADDRESS_ADDRESS = "Address";

     static const String KEY_ACCOUNT_LOGO_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_ACCOUNT_LOGO_ISUPLOADED = "IsUploaded";

     static const String KEY_ACCOUNTMEDIA_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_ACCOUNTMEDIA_ISUPLOADED = "IsUploaded";

     static const String KEY_CONTACTMEDIA_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_CONTACTMEDIA_ISUPLOADED = "IsUploaded";

     static const String KEY_ACTIVITYMEDIA_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_ACTIVITYMEDIA_ISUPLOADED = "IsUploaded";

     static const String KEY_OPPORTUNITYMEDIA_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_OPPORTUNITYMEDIA_ISUPLOADED = "IsUploaded";

     static const String KEY_NOTEMEDIA_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_NOTEMEDIA_ISUPLOADED = "IsUploaded";

     static const String KEY_PRODUCTMEDIA_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_PRODUCTMEDIA_ISUPLOADED = "IsUploaded";

     static const String KEY_ACTIVITYTRAVELMEDIA_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_ACTIVITYTRAVELMEDIA_ISUPLOADED = "IsUploaded";

     static const String KEY_HSSUPPORTTICKETMEDIA_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_HSSUPPORTTICKETMEDIA_ISUPLOADED = "IsUploaded";

     static const String KEY_FIELDATTENDANCE_INTIMEINMINUTES = "InTimeInMinutes";

     static const String KEY_CHATMESSAGE_LOCALMEDIAPATH = "LocalMediaPath";
     static const String KEY_CHATMESSAGE_ISUPLOADED = "IsUploaded";

     static const String KEY_APPUSER_CONFIGURATION = "Configuration";
     static const String KEY_APPUSER_SYSTEMCONFIGURATION = "SystemConfiguration";             //14-Mar-2023

     static const String KEY_APPUSER_MUTECHAT = "MuteChat";

     static const String KEY_CHATUSERGROUPMEMBER_MEMBERNAME = "MemberName";
     static const String KEY_CHATUSERGROUPMEMBER_MEMBERDESCRIPTION = "MemberDescription";
     static const String KEY_CHATUSERGROUPMEMBER_PHONENUMBER = "PhoneNumber";
     static const String KEY_CHATUSERGROUPMEMBER_EMAIL = "Email";

     static const String KEY_RESOURCE_RESOURCECATEGORYNAME = "ResourceCategoryName";

     static const String KEY_APPSYNC_SEQUENTIALORDER = "SequentialOrder";

     static const String KEY_ATTRIBUTE_PARENTATTRIBUTENAME = "ParentAttributeName";       //14-Mar-2023
     static const String KEY_ATTRIBUTEVALUE_PARENTATTRIBUTEVALUENAME = "ParentAttributeValueName";   //14-Mar-2023
	/*-------------------HAPPSALES-------------------*/

}