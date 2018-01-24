import 'package:sqflite/sqflite.dart';
import 'package:heroes_companion_data/src/tables/hero_table.dart' as hero_table;
import 'package:heroes_companion_data/src/tables/ability_table.dart'
    as ability_table;
import 'package:heroes_companion_data/src/tables/talent_table.dart'
    as talent_table;

upgradeTo2(Database database) async {
  await database.execute('''
    ALTER TABLE ${hero_table.table_name}
    ADD COLUMN ${hero_table.column_last_rotation_date} DATETIME 
    ''');
}

upgradeTo3(Database database) async {
  await database.execute('''
    ALTER TABLE ${hero_table.table_name}
    ADD COLUMN ${hero_table.column_have_assets} INTEGER DEFAULT 0 
    ''');

  await database.execute(
      // Update all heroes except Blaze to be marked as having assets
      '''
    UPDATE ${hero_table.table_name}
    SET ${hero_table.column_have_assets} = 1
    WHERE ${hero_table.column_hero_id} IN 
    (33,7,68,28,40,59,41,56,35,5,44,3,13,42,22,45,24,11,52,71,26,64,16,49,12,8,6,50,53,29,9,32,55,31,36,66,73,2,18,63,27,57,14,15,30,62,10,34,75,70,25,69,37,54,48,65,67,58,4,60,38,20,51,1,21,46,72,17,39,61,23,43,47,19,74)
    ''');
}

upgradeTo4(Database database) async {
  await database.execute('''
    ALTER TABLE ${hero_table.table_name}
    ADD COLUMN ${hero_table.column_modified_date} DATETIME 
    ''');
}

upgradeTo5(Database database) async {
  await database.execute(
      '''
      ALTER TABLE ${hero_table.table_name}
      ADD COLUMN ${hero_table.column_sha3_256} TEXT 
      '''
    );

    await database.execute(
      '''
      ALTER TABLE ${talent_table.table_name}
      ADD COLUMN ${talent_table.column_sha3_256} TEXT 
      '''
    );

    await database.execute(
      '''
      ALTER TABLE ${ability_table.table_name}
      ADD COLUMN ${ability_table.column_sha3_256} TEXT 
    '''
    );
}
