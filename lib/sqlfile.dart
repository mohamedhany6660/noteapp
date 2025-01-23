import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class sqldb{

static Database? _db ;

Future<Database?> get db async{
  if(_db==null) {
_db=await initialdb();
return _db;
  }
  else{
    return _db;
    }

}



  initialdb() async {
    String databasepath=await getDatabasesPath();
    String path= await join (databasepath,"mohany.db");
   Database mydb=await openDatabase(path,onCreate: _oncreat,version: 2,onUpgrade: _onupgrade) ;
   return mydb;
  }

  _onupgrade(Database db,int oldversion,int newversion){
    
    
print("gggggggggggggggggggggggggggggggggg");
  }

  _oncreat(Database db,int version)async {


  await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "image" TEXT NOT NULL,
   
  )
''');

print("create===========================");
  
  }

  readData(String sql)async{
    Database? mydb=await db;
    List<Map> respones=await mydb!.rawQuery("$sql");
    return respones;
  }

   insertData(String sql)async{
    Database? mydb=await db;
    int respones=await mydb!.rawInsert("$sql");
     return respones;
  }

 updateData(String sql)async{
    Database? mydb=await db;
    int respones=await mydb!.rawUpdate("$sql");
     return respones;
  }

   deleteData(String sql)async{
    Database? mydb=await db;
    int respones=await mydb!.rawDelete("$sql");
     return respones;
  }

mydelet()async{
   String databasepath=await getDatabasesPath();
    String path= await join (databasepath,"mohany.db");
    await deleteDatabase(path);
}


insert(String table, Map<String, Object?> values)async{
  Database? mydb=await db;
 int respone=await mydb!.insert(table, values);
 return respone;
  
}

}








