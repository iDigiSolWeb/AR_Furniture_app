import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String? itemID;
  String? sellerName;
  String? sellerPhoneNum;
  String? itemName;
  String? itemDesc;
  String? itemUrl;
  double? itemprice;
  Timestamp? publisheddate;
  String? status;

  ItemModel(
      {this.itemID,
      this.sellerName,
      this.sellerPhoneNum,
      this.itemName,
      this.itemDesc,
      this.itemprice,
      this.itemUrl,
      this.publisheddate,
      this.status});

  ItemModel.fromMap(Map<String, dynamic> data) {
    itemID = data['itemID'] == null ? '' : data['itemID'];
    sellerName = data['sellerName'] == null ? '' : data['sellerName'];
    sellerPhoneNum = data['sellerPhoneNum'] == null ? '' : data['sellerPhoneNum'];
    itemName = data['itemName'] == null ? '' : data['itemName'];
    itemDesc = data['itemDesc'] == null ? '' : data['itemDesc'];
    itemUrl = data['itemUrl'] == null ? '' : data['itemUrl'];
    itemprice = data['itemprice'] == null ? 0.00 : (data['itemprice']).toDouble();
    publisheddate = data['publisheddate'] == null ? DateTime.now() : data['publisheddate'];
    status = data['status'] == null ? 'Available' : data['status'];
  }
  //UPLOAD TO DB VIA TOMAP STRUCTURE.-OUT
  Map<String, dynamic> toMap() {
    return {
      'itemID': itemID == null ? '' : itemID,
      'sellerName': sellerName == null ? '' : sellerName,
      'sellerPhoneNum': sellerPhoneNum == null ? '' : sellerPhoneNum,
      'itemName': itemName == null ? '' : itemName,
      'itemDesc': itemDesc == null ? '' : itemDesc,
      'itemUrl': itemUrl == null ? '' : itemUrl,
      'itemprice': itemprice == null ? 0.00 : itemprice,
      'publisheddate': publisheddate == null ? DateTime.now() : publisheddate,
      'status': status == null ? 'Available' : status,
    };
  }
}
