import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sql_first/sqlfile.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  sqldb sqld =sqldb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(children: [
            MaterialButton(onPressed:() async{
//  Future<int> respones=  await sqld.insertData(
  
//   // "INSERT INTO 'notes' 'note' VALUES ('some name')"
//  "INSERT INTO 'notes' 'note' VALUES ('some name'))" 
// );

int response = await sqld.insertData(
  "INSERT INTO notes (note) VALUES ('somm')"
);

print(response);
            },
            
             color:Colors.amber, child: Text("insert"),),
             MaterialButton(onPressed:()async{

 List<Map> respones= await sqld.readData("SELECT * FROM 'notes'");
 print(respones);

             }, color:Colors.red, child: Text("read"),),




        MaterialButton(onPressed: ()async{
     int respones= await sqld.deleteData(" DELETE FROM notes WHERE id = 2");
     print(respones);
        },
        color:Colors.yellow, child: Text("delete"),
        
        ) ,

MaterialButton(onPressed:()async{
 int respones= await sqld.updateData("  UPDATE notes SET note = 'home'  WHERE id = 1 ");
print(respones);
},



  color:Colors.blue, child: Text("update"),
)

          ]),
        ),
      ),

    );
  }
}