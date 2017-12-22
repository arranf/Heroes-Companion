import 'package:sqflite/sqflite.dart';

upgradeTo2(Database database) async{
  await database.rawQuery(
    '''
    ALTER TABLE heroes
    ADD COLUMN 'LastFreeRotationDate' DATETIME 
    '''
  );
}