class Crypto{

    final String id;
    final String name;
    final int isCrypto;
    final double price;


    Crypto({
       required this.id,
       required this.name,
       required this.isCrypto,
       required this.price
    });


    factory Crypto.fromJson(Map<String,dynamic> json){

        return Crypto(
            id:json['asset_id'] as String,
            name:json['name'] as String,
            isCrypto:json['type_is_crypto'] as int,
            price:(json['price_usd'] as num?)?.toDouble()??0.0,
        );
    }
   

}