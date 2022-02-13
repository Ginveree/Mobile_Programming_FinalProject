class Product {
  String? prid;
  String? prmodel;
  String? prprice;
  String? prstockleft;
  String? prfuel;
  String? prcolour;

  Product(
      {required this.prid,
      required this.prmodel,
      required this.prprice,
      required this.prstockleft,
      required this.prfuel,
      required this.prcolour});

  Product.fromJson(Map<String, dynamic> json) {
    prid = json['pID'];
    prmodel = json['pModel'];
    prprice = json['pPrice'];
    prstockleft = json['pStockLeft'];
    prfuel = json['pFuel'];
    prcolour = json['pColour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pID'] = prid;
    data['pModel'] = prmodel;
    data['pPrice'] = prprice;
    data['pStockleft'] = prstockleft;
    data['pFuel'] = prfuel;
    data['pColour'] = prcolour;
    return data;
  }
}
