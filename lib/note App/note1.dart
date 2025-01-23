import 'package:flutter/material.dart';
import 'package:sql_first/note%20App/Editnote.dart';
import 'package:sql_first/note%20App/addnote.dart';
import 'package:sql_first/sqlfile.dart';
class noteapp extends StatefulWidget {
  const noteapp({super.key});

  @override
  State<noteapp> createState() => _noteappState();
}

class _noteappState extends State<noteapp> {
bool isloading=true;
  sqldb sql =sqldb();
  List nott=[];

 Future readData()async{
 List<Map> respones= await sql.readData(" SELECT * FROM 'notes' ");

  nott.addAll(respones);
  isloading=false;
  if(this.mounted)
  setState(() {
    
  });
  } 
  @override
  void initState() {
    readData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Note App  ",style: TextStyle(fontSize: 26,color: Color(0xff333333)),),
            Icon(Icons.book,size: 30,color: Colors.white,)
          ],
        ),
        backgroundColor: Color(0xFF3A7456),
      ),
      floatingActionButton:FloatingActionButton(
        
       
        backgroundColor: Color(0xFF3A7456),
        
        onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => addnote(),));
        FloatingActionButtonLocation:FloatingActionButtonLocation.centerFloat;
      },
      child:Text("Add",style: TextStyle(fontSize: 25,color: Color(0xff333333) ),)
      
      ) ,
      body:isloading==true? 
      Center(child: CircularProgressIndicator())
      : Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          
        color: Color(0xFFF5F5F5),
          child: ListView(children: [
      
      
            ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: nott.length,
                  itemBuilder:(context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Card(
                        color: Color(0xFFF5F5F5) ,
                        child: ListTile(
                          subtitle:Text("${nott[index]["title"]}",
                          style: TextStyle(color: Color(0xFf555555),fontSize: 14,fontWeight: FontWeight.normal,height: 1.4),) ,
                          title: Text("${nott[index]["note"]}",
                          style: TextStyle( color: Color(0xFf333333),fontSize: 18,fontWeight: FontWeight.bold),),
                        
                          trailing:Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            IconButton(icon: Icon(Icons.edit,color: Colors.blueGrey,),
                          onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Edit(
                        color: nott[index]['color'],
                         note: nott[index]['note'],
                         title:nott[index]['title'],
                         id:nott[index]['id']
                       ),));
                       
                          },
                          
                          ),
                        IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                    
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "تأكيد الحذف",
                                              style: TextStyle(color: Color(0xFF3A7456)), // لون متناسق مع اللون الرئيسي
                                            ),
                                            content: Text(
                                              "هل أنت متأكد أنك تريد مسح هذه الملاحظة؟",
                                              style: TextStyle(color: Colors.black),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); 
                                                },
                                                child: Text("إلغاء", style: TextStyle(color: Color(0xFF3A7456))),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                 
                                                  int response = await sql.deleteData('''
                                                    DELETE FROM notes WHERE id = ${nott[index]['id']}
                                                  ''');
                                                  if (response > 0) {
                                                    setState(() {
                                                    
                                                      nott.removeWhere((element) => element['id'] == nott[index]['id']);
                                                    });

                                                   
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('تم مسح الملاحظة بنجاح!',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                                                        backgroundColor: Color(0xFF3A7456), // لون نجاح المسح
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );
                                                  } else {
                                                   
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('فشل في مسح الملاحظة.',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
                                                        backgroundColor: Colors.red, // لون فشل المسح
                                                        duration: Duration(seconds: 2),
                                                      ),
                                                    );
                                                  }
                                                  Navigator.of(context).pop(); 
                                                },
                                                child: Text("مسح", style: TextStyle(color: Colors.red)),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}