import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/db/summary.dart';
import 'package:movies/log/auth.dart';
import 'package:movies/provider/paymentmethod.dart';
import 'package:movies/service/fetchapi.dart';
import 'package:movies/widget/moviebuy.dart';
import 'package:movies/widget/paymentmethodlist.dart';
import 'package:movies/widget/texttheme.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class ConfirmSummary extends StatelessWidget {
  const ConfirmSummary({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Box<summary> box = Hive.box<summary>(MyBox);
    List<Widget> movie = [];
    if(box.length != 0){
      for(int i = 0;i<box.length;i++){
        final sum = box.getAt(i);
        movie.add(
          Moviebuy(
            name: sum!.name,
            background: sum.background,
            head: sum.head,
            rating: sum.rating,
            type: sum.type,
            view: sum.view,
            trailer: sum.trailer,
            director: sum.director,
            actor: sum.actor,
            description: sum.description,
            full: sum.full,
            buy: sum.buy,
            index: i,
          )
        );
      }
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: TextWhite("Select a payment method", 16),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: TextWhite("ITEM", 16),
          ),
          Container(
            width: width,
            height: height*0.14*box.length,
            child: Column(
              children: movie,
            ),
          ),
          Container(
            width: width,
            height: height*0.2,
            child: ValueListenableBuilder(
              valueListenable: Hive.box<summary>(MyBox).listenable(),
              builder: (context,box,widget){
                Box<summary> box = Hive.box<summary>(MyBox);
                final sum = box.length;
                int total = 0;
                for(var i=0;i<sum;i++){
                  final val = box.getAt(i)!.buy;
                  if(val == "Buy"){
                    total += 500;
                  }
                  else{
                    total += 300;
                  }
                }
                return Column(
                  children: (sum == 0)?
                  [
                    ListTile(
                      leading: TextWhite("Sub-total", 12),
                      trailing: InkWell(
                        child: TextWhite("฿ 0", 16),
                        onTap: (){
                        
                        },
                      ),
                    ),
                    ListTile(
                      leading: TextWhite("Discount", 12),
                      trailing: InkWell(
                        child: TextWhite("฿ 0", 16),
                        onTap: (){
                        
                        },
                      )
                    ),
                    ListTile(
                      leading: TextWhite("Total", 12),
                      trailing: InkWell(
                        child: TextOrange("฿ 0", 20),
                        onTap: (){
                        
                        },
                      )
                    ),
                  ]:
                  [
                    ListTile(
                      leading: TextWhite("Sub-total", 12),
                      trailing: InkWell(
                        child: TextWhite("฿ $total", 16),
                        onTap: (){
                        
                        },
                      ),
                    ),
                    ListTile(
                      leading: TextWhite("Discount", 12),
                      trailing: InkWell(
                        child: TextWhite("฿ 0", 16),
                        onTap: (){
                        
                        },
                      )
                    ),
                    ListTile(
                      leading: TextWhite("Total", 12),
                      trailing: InkWell(
                        child: TextOrange("฿ $total", 20),
                        onTap: (){
                        
                        },
                      )
                    ),
                  ],
                );
              },
            )
          ),
          ListTile(
            leading: TextWhite("PAYMENT METHOD", 16),
          ),
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_)=> PaymentMethod())
            ],
            child: const PaymentMethodList(),
          ),
        ],
      ),
    );
  }
}