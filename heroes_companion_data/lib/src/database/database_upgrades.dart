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

upgradeTo6(Database database) async {
  // Add columns for abilities and talents having an asset stored on device 
  await database.execute(
    '''
    ALTER TABLE ${ability_table.table_name}
    ADD COLUMN ${ability_table.column_have_asset} INTEGER DEFAULT 0
    '''
  );

  await database.execute(
    '''
    ALTER TABLE ${talent_table.table_name}
    ADD COLUMN ${talent_table.column_have_asset} INTEGER DEFAULT 0
    '''
  );

  // Ensure all current heroes, talents, and abilities are marked as being on device
  await database.execute(
    '''
    UPDATE ${ability_table.table_name}
    SET ${ability_table.column_have_asset} = 1
    '''
  );

  await database.execute(
    '''
    UPDATE ${talent_table.table_name}
    SET ${talent_table.column_have_asset}  = 1
    '''
  );

  await database.execute(
    '''
    UPDATE ${hero_table.table_name}
    SET ${hero_table.column_have_assets}  = 1
    '''
  );
}
