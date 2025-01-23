import 'package:flutter/material.dart';
import 'package:sql_first/note%20App/note1.dart';
import 'package:sql_first/sqlfile.dart';

class addnote extends StatefulWidget {
  const addnote({super.key});

  @override
  State<addnote> createState() => _addnoteState();
}

class _addnoteState extends State<addnote> {
  sqldb sql=sqldb();

  GlobalKey<FormState> notesss=GlobalKey();
  TextEditingController note =TextEditingController();
   TextEditingController title =TextEditingController();
    TextEditingController color =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(children: [
      Container(height: 100,),
              Form(
                key: notesss,
                child:Column(children: [
                  TextFormField(
                    controller: note,
                maxLines: null,
                    decoration: InputDecoration(
                      
                      hintText: "Title"
                    ),
                     validator: (value) {
                      if(value==null||value.isEmpty){
                        return "please write Title";
                      }return null;
                    },
                  ),
      Container(height: 30,),
                   TextFormField(
                    controller: title,
                     maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "note"
                    ),
                    validator: (value) {
                      if(value==null||value.isEmpty){
                        return "please write note";
                      }return null;
                    },
                  ),
              Container(height: 30,),
                   TextFormField(
                    controller: color,
                     maxLines: null,
                    decoration: InputDecoration(
                      hintText: "color"
                    ),
                     validator: (value) {
                      if(value==null||value.isEmpty){
                        return "please write color";
                      }return null;
                    },
                  ),
    Container(height: 30,),
                  MaterialButton(
                    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),

                    minWidth: 200,
                        onPressed: () async {
                          if (notesss.currentState?.validate() ?? false) {
                           
                            int response = await sql.insertData('''
                              INSERT INTO notes(note, title, color) 
                              VALUES('${note.text}', '${title.text}', '${color.text}')
                            ''');

                            if (response > 0) {
                              
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تم إضافة الملاحظة بنجاح!',style: TextStyle(fontSize: 18,color:Color(0xff333333)),),
                                  backgroundColor: Color (0xFF3A7456), 
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => noteapp()));
                            } else {
                            
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('فشل إضافة الملاحظة.',style: TextStyle(fontSize: 18,color:Color(0xff333333)),),
                                  backgroundColor: Colors.red, 
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        color: Color(0xFF3A7456),
                        child: Text("أضف الملاحظة", style: TextStyle(color:Color(0xff333333))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}