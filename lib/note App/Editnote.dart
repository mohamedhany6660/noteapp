import 'package:flutter/material.dart';
import 'package:sql_first/note%20App/note1.dart';
import 'package:sql_first/sqlfile.dart';
class Edit extends StatefulWidget {
  const Edit({super.key, this.note, this.title, this.id, this.color});

  final note;
  final title;
  final id;
  final color;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
sqldb sql=sqldb();
  GlobalKey<FormState> Edit =GlobalKey();
  TextEditingController note=TextEditingController();
  TextEditingController title=TextEditingController();
  TextEditingController color=TextEditingController();

  @override
  void initState() {
    note.text=widget.note;
    title.text=widget.title;
    color.text=widget.color;
    

    super.initState();
  }
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
      body:  Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(children: [
      
              Center(
                child: Form(
                  key: Edit,
                  child:Column(children: [
                    Container(height: 100,),
                    TextFormField(
                      controller: note,
                       maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Title"
                      ),
                      validator: (value) {
                        if(value==null||value.isEmpty){
                          return "please write title";
                        }return null;
                      },
                    ),
                       Container(height: 30,),
                     TextFormField(
                      controller: title,
                       maxLines: null,
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
                            if (Edit.currentState?.validate() ?? false) {
                              int response = await sql.updateData('''
                                UPDATE notes SET
                                note = '${note.text}',
                                title = '${title.text}',
                                color = '${color.text}'
                                WHERE id = '${widget.id}'
                              ''');
                              
                              if (response > 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                     backgroundColor: Color(0xFF3A7456), 
                                    content: Text('تم تعديل الملاحظة بنجاح!',style: TextStyle(fontSize: 18,color:Color(0xff333333)),)),
                                );
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => noteapp()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Color(0xFF3A7456), 
                                    content: Text('فشل تعديل الملاحظة.',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)),
                                );
                              }
                            }
                          },
                          color: Color(0xFF3A7456),
                          child: Text("تعديل الملاحظة", style: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
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