import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasework/firebaseclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'imagescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    getdata();
  }
  void getdata()
  async{
    l1.value = await Userprofile();
  }
  TextEditingController txtid = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmob = TextEditingController();
  TextEditingController txtstd = TextEditingController();
  TextEditingController utxtid = TextEditingController();
  TextEditingController utxtname = TextEditingController();
  TextEditingController utxtmob = TextEditingController();
  TextEditingController utxtstd = TextEditingController();
  List<DataModel> datalist = [];
  RxList l1 = [].obs;
  Timer? _timer;
  late double _progress;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: (){
             Get.defaultDialog(
               content: Padding(
                 padding: const EdgeInsets.all(10),
                 child: Column(
                   children: [
                     TextField(
                       controller: txtid,
                       decoration: InputDecoration(
                         hintText: 'Id',
                       ),
                     ),
                     SizedBox(height: 10,),
                     TextField(
                       controller: txtname,
                       decoration: InputDecoration(
                         hintText: 'Name',
                       ),
                     ),
                     SizedBox(height: 10,),
                     TextField(
                       controller: txtmob,
                       decoration: InputDecoration(
                         hintText: 'Mobile',
                       ),
                     ),
                     SizedBox(height: 10,),
                     TextField(
                       controller: txtstd,
                       decoration: InputDecoration(
                         hintText: 'Std',
                       ),
                     ),
                     SizedBox(height: 10,),
                     ElevatedButton(onPressed: (){
                       insertdata(txtid.text, txtname.text,txtmob.text, txtstd.text);
                       Get.back();
                       txtid.clear();
                       txtname.clear();
                       txtmob.clear();
                       txtstd.clear();
                     }, child: Text("Add"))
                   ],
                 ),
               ),
               title: 'Add Details',
             );
            },child: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                logouts();
                Get.offNamed('login');
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        // body: Center(
        //   child: Obx(
        //       ()=> Column(
        //         children: [
        //           Text("${l1[0]}"),
        //           Text("${l1[1]}")
        //         ],
        //       ),
        //   ),
        // ),
        body: StreamBuilder(
          stream: readdata(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasError)
            {
              return Text("${snapshot.error}");
            }else if(snapshot.hasData)
            {
              var docs = snapshot.data!.docs;
              datalist.clear();
              for(QueryDocumentSnapshot x in docs)
              {
                var data = x.data() as Map<String,dynamic>;
                String key = x.id;
                String id = data['id'];
                String name = data['name'];
                String std = data['std'];
                DataModel m1 = DataModel(
                  id: id,name: name,std: std,key: key,
                );
                datalist.add(m1);
              }
              return ListView.builder(
                  itemCount: datalist.length,
                  itemBuilder: (context,index){
                    return
                      Container(
                        height: 55,
                        child: Card(
                          color: Colors.grey.shade400,
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${datalist[index].id}"),
                              Text("${datalist[index].name}"),
                              Text("${datalist[index].key}"),
                              Text("${datalist[index].std}"),
                              IconButton(onPressed: (){
                                utxtid = TextEditingController(text: "${datalist[index].id}");
                                utxtname = TextEditingController(text: "${datalist[index].name}");
                                utxtmob = TextEditingController(text: "${datalist[index].mob}");
                                utxtstd = TextEditingController(text: "${datalist[index].std}");
                                Get.defaultDialog(
                                  title: "Details",
                                  backgroundColor: Colors.grey,
                                  content: Column(
                                    children: [
                                      TextField(controller: utxtid,),
                                      SizedBox(height: 10,),
                                      TextField(controller: utxtname,),
                                      SizedBox(height: 10,),
                                      TextField(controller: utxtmob,),
                                      SizedBox(height: 10,),
                                      TextField(controller: utxtstd,),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: (){
                                              updatedata("${datalist[index].key}", utxtid.text, utxtname.text, utxtmob.text, utxtstd.text);
                                              Get.back();
                                            }, style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green
                                          ),
                                            child: Text("Edit"),),
                                          ElevatedButton(onPressed: (){
                                            deletedata("${datalist[index].key}");
                                            Get.back();
                                          }, style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red
                                          ),
                                            child: Text("Delete"),),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }, icon: Icon(Icons.menu))
                            ],
                          ),
                        ),
                      );
                  });
            }
            return Center(child: CircularProgressIndicator(),);
            // return  TextButton(
            //   child: Text('show'),
            //   onPressed: () async {
            //     _timer?.cancel();
            //     await EasyLoading.show(
            //       status: 'loading...',
            //       maskType: EasyLoadingMaskType.black,
            //     );
            //     print('EasyLoading show');
            //   },
            // );
          },
        ),
      ),
    );
  }
}
