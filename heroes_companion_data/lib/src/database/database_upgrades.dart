import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/tables/hero_table.dart' as hero_table;

upgradeTo2(Database database) async{
  await database.execute(
    '''
    ALTER TABLE ${hero_table.table_name}
    ADD COLUMN ${hero_table.column_last_rotation_date} DATETIME 
    '''
  );
}