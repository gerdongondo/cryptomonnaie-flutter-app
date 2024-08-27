import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:cryptoapp/models/crypto.dart';
import 'package:cryptoapp/services/crypto_api.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      debugShowCheckedModeBanner:false,
       theme:ThemeData(
        primarySwatch:Colors.blue,
       ),
      home: const CryptoScreen(),
    );
  }
}


class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
    late Future<List<Crypto>> _cryptos;

    @override
    void initState(){
      super.initState();
      _cryptos=CryptoApi.getCryptos();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text('Crypto App'),
        backgroundColor:Colors.red,
        foregroundColor:Colors.black,
      ),
      backgroundColor:Colors.grey.shade900,
      body:FutureBuilder<List<Crypto>>(
        future:_cryptos ,
        builder:(context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child:CircularProgressIndicator(),);
          }else if(snapshot.hasError){
            return Center(child:Text('Error:${snapshot.error}'),);
          }else if(!snapshot.hasData||snapshot.data!.isEmpty){
            return const Center(child: Text('No data found'),);
          }else{
             final cryptos=snapshot.data!;
             return ListView.builder(
              itemCount:cryptos.length,
              itemBuilder: (context,index){
               final crypto=cryptos[index];
               if(crypto.isCrypto!=1){
                return Container();
               }
              return ListTile(
                title:Text(
                  crypto.id,
                  style:const TextStyle(color:Colors.white),
                ),
                subtitle:Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Text(
                      crypto.name,
                      style:const TextStyle(color:Colors.grey),
                    ),
                    Text(
                      '\$${crypto.price}',
                      style:const TextStyle(color:Colors.grey),
                    )
                  ],
                  ),
                  leading:TextAvatar(
                    text:crypto.name,
                    shape: Shape.Circular,
                    textColor: Colors.black,
                    fontWeight: FontWeight.normal,
                    size: 41,
                    numberLetters: 2,
                    ),
              );

              });
            
          }
        },
      ),
    );
  }
}