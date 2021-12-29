import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/db/summary.dart';
import 'package:movies/routes/navigator.dart';
import 'package:movies/widget/moviebuy.dart';
import 'package:movies/widget/texttheme.dart';

import '../main.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Box<summary> box = Hive.box<summary>(MyBox);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: (){
             NavigatorPage(context);
          },
        ),
        title: TextWhite("Order Summary", 18),
      ),
      body: Column(
        children: [
          ListTile(
            leading: TextWhite("ITEM", 16),
            trailing: InkWell(
              child: Textblue("Add Other Item", 12),
              onTap: (){
                NavigatorPage(context);
              },
            )
          ),
          Container(
            width: width,
            height: height*0.49,
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (context,index){
                if(box.length == 0){
                  return Container();
                }
                else{
                  final sum = box.getAt(index);
                  return Moviebuy(
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
                    index: index,
                  );
                }
              }
            ),
          ),
          Expanded(
            child: SpaceGap(0.0001, AxisType.vertical)
          ),
          Container(
            width: width,
            height: height*0.29,
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
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 0.0
                          ),
                          child: Container(
                            width: width,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff33FFFF),
                                  Color(0xff00ccff),
                                ]
                              )
                            ),
                            child: Center(
                              child: TextWhite("Continue to Payment >", 16)
                            ),
                          ),
                        ),
                        onTap: (){
                          NavigatorComfirmSummary(context);
                        },
                      ),
                  ],
                );
              },
            )
          )
        ],
      ),
    );
  }
}