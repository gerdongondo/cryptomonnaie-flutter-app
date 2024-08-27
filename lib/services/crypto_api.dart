
import 'dart:convert';
import 'package:http/http.dart' as http;
import  'package:cryptoapp/models/crypto.dart';


class CryptoApi{
    static const String cryptoUrl='https://rest.coinapi.io/v1/assets';
    static const String apiKey='59C92748-9BE4-4493-B0EF-B3404C716DA3';

   static Future<List<Crypto>> getCryptos() async {
    
    final response =await http.get(Uri.parse(cryptoUrl),headers:{
        'X-CoinAPI-Key':apiKey,
    });

     if(response.statusCode==200){
        final List<dynamic> jsonList=json.decode(response.body);
        return jsonList.map((json)=>Crypto.fromJson(json)).toList();
     } else{
        throw Exception('Failed to load cryptos');
     }
   

} 

}